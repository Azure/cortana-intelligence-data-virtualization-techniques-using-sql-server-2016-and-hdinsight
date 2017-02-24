# Run this script to install data virtualization dependencies on this server
#
# RUN:
# powershell.exe -ExecutionPolicy Unrestricted -File Install.ps1

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"
Start-Transcript -Path C:\Windows\Temp\dv-install.log

$SQL_SETUP = "C:\SQLServer_13.0_Full\setup.exe";
$POLYBASE_CONF = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf";

Add-Type -Assembly "System.IO.Compression.FileSystem"
$client = New-Object Net.Webclient

function Get-PrimaryNamenode([string]$hosts, [int]$port = 30070) {
  return $hosts.Split(',') | ? {
    $status = $client.DownloadString("http://$($_):$port/jmx?qry=Hadoop:service=NameNode,name=NameNodeStatus") | ConvertFrom-Json
    $status.beans[0].state -eq "active"
  }
}

function Get-PrimaryResourceManager([string]$hosts, [int]$port = 8088) {
  [regex]$pattern = "<th>\s+ResourceManager HA state:\s+</th>\s+<td>\s+(active|standby)\s+</td>"
  return $hosts.Split(',') | ? {
    $html = $client.DownloadString("http://$($_):$port/cluster/cluster")
    $pattern.Match($html).Groups[1].Value -eq "active"
  }
}

function Get-HadoopVersion([string]$host, [int]$port) {
  $info = $client.DownloadString("http://$($hadoopNamenode):$NAMENODE_PORT/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo") | ConvertFrom-Json
  return [String]::Join(".", $info.beans[0].SoftwareVersion.split(".")[-4..-1])
}

function New-Credential([string]$username, [string]$password) {
  $securepw =  ConvertTo-SecureString $password -AsPlainText -Force
  return New-Object Management.Automation.PSCredential("$env:COMPUTERNAME\$username", $securepw)
}

function Get-Vars([string]$path = "C:\Windows\Temp\dv-env.json") {
  return ConvertFrom-PSObject (Get-Content $path | ConvertFrom-Json)
}

function Get-DestinationPath([string]$path, [string]$workingDir) {
  if (! ([IO.Path]::IsPathRooted($path))) {
    $path = [IO.Path]::Combine($workingDir, $path)
  }
  return $path
}

function ConvertFrom-PSObject([psobject]$object) {
  $hash = @{}
  $object.PSObject.Properties | % {
    $hash[$_.Name] = $_.Value
  }
  return $hash
}

function Write-FileVars([IO.FileInfo]$file, [hashtable]$vars, [regex]$pattern = "\$\(([^)]+)\)") {
  $dest = $file.FullName.Replace(".tpl", [String]::Empty)
  $replacer = { $vars[$args[0].Groups[1].Value] }
  "Writing environment variables to {0}" -f $dest | Write-Verbose
  $file | Get-Content | % {
    $pattern.Replace($_, $replacer)
  } | Out-File $dest -Encoding ascii
}

function Run-Process([string]$path, [string]$arg) {
  "Executing {0} {1}" -f $path, $arg | Write-Verbose
  $pi = New-Object Diagnostics.ProcessStartInfo($path, $arg)
  $pi.UseShellExecute = $true
  $pi.Verb = "runas"
  $proc = New-Object Diagnostics.Process
  $proc.StartInfo = $pi
  if (!$proc.Start()) {
    return 1
  }
  $proc.WaitForExit()
  "EXIT CODE: {0}" -f $proc.ExitCode | Write-Verbose
  return $proc.ExitCode
}

function Create-DirIfNotExists([string]$path) {
  if (! (Test-Path $path)) {
    New-Item $path -Type Directory
  }
}

function Remove-DirIfExists([string]$path) {
  if (Test-Path $path) {
    Remove-Item $path -Recurse -Force
  }
}

$vars = Get-Vars;
$currentDir = [IO.Path]::GetFullPath($pwd)
$tutorialDir = "C:\Tutorial"

Get-ChildItem $tutorialDir -exclude Setup,Install.ps1 -Recurse | Remove-Item -Force -Recurse

$files = @{
  polybase = @{ name="PolyBase.ini"; uri=$vars.PolybaseConfigUri; dest="." };
  mapred = @{ name="mapred-site.xml.tpl"; uri=$vars.MapReduceConfigUri; dest="templates" };
  adventureWorks = @{ name="AdventureWorks2012_Data.mdf"; uri=$vars.AdventureWorksUri; dest=([IO.Path]::Combine($tutorialDir, "db")) };
  jre = @{ name="jre-8u121-windows-x64.exe"; uri=$vars.JreUri; dest="." };
  sql = @{ name="sql.zip"; uri=$vars.SqlScriptsUri; dest="templates" };
  adventureWorksDW = @{ name="AdventureWorksSQLDW2012.zip"; uri=$vars.AdventureWorksDWUri; dest="." } }

$files.Values | % {
  $_.dir = Get-DestinationPath $_.dest $currentDir
  $_.path = [IO.Path]::Combine($_.dir, $_.name)

}

$zips = $files.Values | ? { [IO.Path]::GetExtension($_.name) -eq ".zip" } 
$zips | % {
  $name = [IO.Path]::GetFileNameWithoutExtension($_.name)
  $_.extractTo = [IO.Path]::Combine($_.dir, $name)
}

# download remote files
$files.Values | % {
  "Downloading {0} to {1}" -f $_.uri, $_.path | Write-Verbose
  Create-DirIfNotExists $_.dir
  $client.DownloadFile($_.uri, $_.path)
}

# extract zips
$zips | % {
  "Extracting {0} to {1}" -f $_.path, $_.extractTo | Write-Verbose
  Remove-DirIfExists $_.extractTo
  [IO.Compression.ZipFile]::ExtractToDirectory($_.path, $_.extractTo)
}

# replace template vars
"Replacing template variables" | Write-Verbose
$templates = Get-ChildItem $currentDir -File -Recurse -Include *.tpl | % {
  Write-FileVars $_ $vars
}

# copy sql scripts from staging
"Copying SQL scripts" | Write-Verbose
Copy-Item $files.sql.extractTo ([IO.Path]::Combine($tutorialDir, "sql")) -Exclude *.tpl -Recurse

# execute commands
@(
  @{  path = $files.jre.path;
      args = "/s" };

  @{  path = $vars.SqlInstaller; 
      args = ("/configurationfile={0}" -f $files.polybase.path) };

  @{  path = "sqlcmd";
      args = ("-Q ""CREATE DATABASE AdventureWorks2012 ON (FILENAME='{0}') FOR ATTACH_REBUILD_LOG;""" -f $files.adventureWorks.path) };

  @{  path = ([IO.Path]::Combine($files.adventureWorksDW.extractTo, "aw_create.bat"));
      args = [string]::Join(" ", ($vars.SqlServer, $vars.AdminUser, $vars.AdminPassword, $vars.SqlDWDatabase, $files.adventureWorksDW.extractTo)) };

  @{  path = "sqlcmd";
      args = ("-i {0}" -f [IO.Path]::Combine($tutorialDir, "sql", "bootstrap", "setup.sql")) } 
) | % {
  $result = Run-Process $_.path $_.args
  if ($result -ne 0) {
    "Exiting due to execution failure" | Write-Warning
    exit $result
  }
}

# copy polybase config
"Copying MapRed config" | Write-Verbose
Copy-Item ($files.mapred.path.Replace(".tpl", [String]::Empty)) $vars.PolybaseConfigDir

# restart polybase
"Restarting PolyBase" | Write-Verbose
@("SQLPBENGINE"; "SQLPBDMS";) | Restart-Service

Stop-Transcript