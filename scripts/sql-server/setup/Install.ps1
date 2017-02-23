[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True, Position=1)]
  [string]$MasterKey,
	
  [Parameter(Mandatory=$True, Position=2)]
  [string]$StorageAccount,
  
  [Parameter(Mandatory=$True, Position=3)]
  [string]$StorageKey,
  
  [Parameter(Mandatory=$True, Position=4)]
  [string]$StorageContainer,
  
  [Parameter(Mandatory=$True, Position=5)]
  [string]$AdminUser,
  
  [Parameter(Mandatory=$True, Position=6)]
  [string]$AdminPassword,
  
  [Parameter(Mandatory=$True, Position=7)]
  [string]$HadoopHeadnodes,

  [Parameter(Mandatory=$True, Position=8)]
  [string]$SQLServer,

  [Parameter(Mandatory=$True, Position=9)]
  [string]$SQLDWDatabase,
  
  [string]$SQLInstaller = "C:\SQLServer_13.0_Full\setup.exe",
  
  [string]$PolyBaseConfig = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf",
  
  [string]$PolyBaseInstallConfigUri = "http://bostondata.blob.core.windows.net/edw-data-virtualization/PolyBase.ini",
  
  [string]$MapReduceConfigUri = "http://bostondata.blob.core.windows.net/edw-data-virtualization/mapred-site.xml.tpl",
  
  [string]$SqlScriptsUri = "http://bostondata.blob.core.windows.net/edw-data-virtualization/sql.zip",
  
  [string]$AdventureWorksDbUri = "http://bostondata.blob.core.windows.net/edw-data-virtualization/AdventureWorks2012_Data.mdf",
    
  [string]$JreUri = "http://bostondata.blob.core.windows.net/edw-data-virtualization/jre-8u121-windows-x64.exe",

  [string]$AdventureWorksSQLDW2012Uri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/AdventureWorksSQLDW2012.zip"
)

# RUN:
# powershell.exe -ExecutionPolicy Unrestricted -File Install.ps1 <args...>

"Current user: {0}" -f (& whoami)

# Discover Hadoop active nodes
$NAMENODE_PORT = 30070
$RESOURCE_MANAGER_PORT = 8088
$RM_REGEX = [regex]"<th>\s+ResourceManager HA state:\s+</th>\s+<td>\s+(active|standby)\s+</td>"
$client = New-Object Net.Webclient

"Discovering active Hadoop namenode"
$hadoopNamenode = $HadoopHeadnodes.Split(',') | ? {
    $status = $client.DownloadString("http://$($_):$NAMENODE_PORT/jmx?qry=Hadoop:service=NameNode,name=NameNodeStatus") | ConvertFrom-Json
    $status.beans[0].state -eq "active"
}
$hadoopNamenode
if (!$hadoopNamenode) {
    throw New-Object Exception "Could not find active namenode"
}

"Discovering active Hadoop resource manager"
$hadoopResourceManager = $HadoopHeadnodes.Split(',') | ? {
    $html = $client.DownloadString("http://$($_):$RESOURCE_MANAGER_PORT/cluster/cluster")
    $RM_REGEX.Match($html).Groups[1].Value -eq "active"
}
$hadoopResourceManager
if (!$hadoopResourceManager) {
    throw New-Object Exception "Could not find active resource manager"
}

"Discovering Hadoop version"
$info = $client.DownloadString("http://$($hadoopNamenode):$NAMENODE_PORT/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo") | ConvertFrom-Json
$hadoopVersion = [String]::Join(".", $info.beans[0].SoftwareVersion.split(".")[-4..-1])
$hadoopVersion

$password =  ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$credential = New-Object Management.Automation.PSCredential("$env:COMPUTERNAME\$AdminUser", $password)
$current = [IO.Path]::GetFullPath($pwd)
$vars = @{
  MASTER_KEY = $MasterKey;
  STORAGE_ACCOUNT_NAME = $StorageAccount;
  STORAGE_ACCOUNT_KEY = $StorageKey;
  STORAGE_CONTAINER_NAME = $StorageContainer;
  HDI_USERNAME = $AdminUser;
  HDI_PASSWORD = $AdminPassword;
  HDI_NAMENODE_HOST = $hadoopNamenode;
  HDI_RESOURCE_MANAGER_HOST = $hadoopResourceManager;
  HDP_VERSION = $hadoopVersion;
  SQL_SERVER = $SQLServer;
  SQLDW_DATABASE = $SQLDWDatabase; }
$locals = @{
  sql = "C:\SQLServer_13.0_Full\setup.exe";
  polybase = "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Binn\Polybase\Hadoop\conf"; }
$uris = @{
  polybase = $PolyBaseInstallConfigUri;
  mapred = $MapReduceConfigUri;
  scripts = $SqlScriptsUri;
  db = $AdventureWorksDbUri;
  jre = $JreUri;
  awsqldw = $AdventureWorksSQLDW2012Uri; }

# run as admin
$result = Invoke-Command localhost {
  $current = $args[0]
  $vars = $args[1]
  $locals = $args[2]
  $uris = $args[3]

  "Current user: {0}" -f (& whoami)
  "Environment"; $vars.GetEnumerator() | % { "{0}: {1}" -f $_.Name, $_.Value }

  $sqlServer = $vars.Item("SQL_SERVER")
  $sqlUser = $vars.Item("HDI_USERNAME")
  $sqlPassword = $vars.Item("HDI_PASSWORD")
  $sqldwDatabase = $vars.Item("SQLDW_DATABASE")

  # required for unzip
  Add-Type -Assembly "System.IO.Compression.FileSystem"

  # files to download
  $fileHashAlgo = "MD5"
  $polybaseFile = @{ name = "PolyBase.ini"; uri = $uris.polybase; hash = "CBC401A9F21DE801A922C1AB321FF4EE" }
  $mapredFile = @{ name = "mapred-site.xml.tpl"; uri = $uris.mapred; hash = "838685858442F81E2B4FD850FCAB6853" }
  $sqlScriptsFile = @{ name = "sql.zip"; uri = $uris.scripts; hash = "71E9C789D4C0AE083205A885DFB56098" }
  $dbFile = @{ name = "AdventureWorks2012_Data.mdf"; uri = $uris.db; hash = "C3E2FFA06302694203DDADB52A8C00B1" }
  $jreFile = @{ name = "jre-8u121-windows-x64.exe"; uri = $uris.jre; hash = "A963C6B8A012E658A3D657C4897CF7C8" }
  $awsqldwFile = @{ name = "AdventureWorksSQLDW2012.zip"; uri = $uris.awsqldw; hash = "998EAFD464937B2D8A809E7B51AD3188" }
  $workingDir = "C:\Tutorial"
  $dbDir = [IO.Path]::Combine($workingDir, 'db')
  $scriptsStagingDir = [IO.Path]::Combine($current, 'sql')
  $scriptsZip = [IO.Path]::Combine($current, $sqlScriptsFile.name)
  $mapredStagingFile = [IO.Path]::Combine($current, $mapredFile.name)
  $awsqldwDir = [IO.Path]::Combine($workingDir, 'AdventureWorksSQLDW2012')
  $awsqldwZip = [IO.Path]::Combine($current, $awsqldwFile.name)

  # download files
  $client = New-Object Net.Webclient
  @($polybaseFile; $mapredFile; $sqlScriptsFile; $dbFile; $jreFile).GetEnumerator() | % {
    $dest = [IO.Path]::Combine($current, $_.name)
    if (!(Test-Path $dest -Type Leaf) -or ((Get-FileHash $dest -Algorithm $fileHashAlgo | select -ExpandProperty Hash) -ne $_.hash)) {
      "[ DOWNLOADING {0} to {1}" -f $_.uri, $dest
      $client.Downloadfile($_.uri, $dest)
    }
  }

  # clean up existing
  if ((Test-Path $workingDir -PathType Container)) {
    "Removing $workingDir"
    Remove-Item $workingDir -Recurse -Force
  }

  # create working dir
  "Creating $workingDir"
  New-Item $workingDir -Type Directory

  # extract AdventureWorksSQLDW2012
  "Extracting $awsqldwZip to $awsqldwDir"
  [IO.Compression.ZipFile]::ExtractToDirectory($awsqldwZip, $awsqldwDir)

  "Creating $dbDir"
  New-Item $dbDir -Type Directory

  # environment vars
  "Extracting $scriptsZip to $scriptsStagingDir"
  [IO.Compression.ZipFile]::ExtractToDirectory($scriptsZip, $scriptsStagingDir)
  $templateFiles = Get-ChildItem $scriptsStagingDir,$mapredStagingFile -File -Recurse -Include *.tpl
  $re = [regex] "\$\(([^)]+)\)"
  $replacer = { $vars[$args[0].Groups[1].Value] }
  $templateFiles | % {
    $name = $_.FullName.Replace(".tpl", [String]::Empty)
    "Setting vars in $name from $($_.FullName)"
    $_ | Get-Content | % { $re.Replace($_, $replacer) } | Out-File $name -Encoding ascii
  }

  # copy sample db
  "Copying $($dbFile.name) to $dbDir"
  Copy-Item ([IO.Path]::Combine($current, $dbFile.name)) $dbDir

  # copy scripts
  "Copying $scriptsStagingDir to $workingDir"
  Copy-Item -Exclude *.tpl -Recurse $scriptsStagingDir $workingDir

  # execute
  $commands = @(
    @{ path = ([IO.Path]::Combine($current, $jreFile.name)); 
       args = "/s" };
    @{ path = $locals.sql; 
       args = ("/configurationfile={0}" -f [IO.Path]::Combine($current, $polybaseFile.name)) };
    @{ path = "sqlcmd";
       args = ("-Q ""CREATE DATABASE AdventureWorks2012 ON (FILENAME='{0}') FOR ATTACH_REBUILD_LOG;""" -f [IO.Path]::Combine($dbDir, $dbFile.name)) };
    @{ path = ([IO.Path]::Combine($awsqldwDir, "aw_create.bat"));
       args = ("$sqlServer $sqlUser $sqlPassword $sqldwDatabase $awsqldwDir") };
    @{ path = "sqlcmd";
       args = ("-i $([IO.Path]::Combine($workingDir, "sql", "bootstrap", "setup.sql"))") })
  for ($i = 0; $i -lt $commands.Length; $i += 1) {
    $cmd = $commands[$i]
    "[ EXECUTING {0} {1}]" -f $cmd.path, $cmd.args
    $result = Start-Process -FilePath $cmd.path -ArgumentList $cmd.args -Wait -PassThru -Verb "runas"
    if ($result.ExitCode -ne 0) {
      "{0} execution failed with exit code {1}" -f $cmd.path, $result.ExitCode; $result
      return $result.ExitCode
    }
  }

  # copy polybase config
  "Copying $($mapredFile.name.Replace(".tpl", [String]::Empty)) to $($locals.polybase)"
  Copy-Item ([IO.Path]::Combine($current, $mapredFile.name.Replace(".tpl", [String]::Empty))) $locals.polybase

  # RESTART SQL
  "Restarting SQL services"
  @("SQLPBENGINE"; "SQLPBDMS";) | Restart-Service
  return 0
} -Credential $credential -ArgumentList $current, $vars, $locals, $uris

$result
exit $result