# This script is meant to be executed via an ARM deploy extension.
# There should be no need to run it again
#
# RUN:
# powershell.exe -ExecutionPolicy Unrestricted -File Deploy.ps1 <args...>

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
  
  [string]$PolyBaseInstallConfigUri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/PolyBase.ini",
  
  [string]$MapReduceConfigUri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/mapred-site.xml.tpl",
  
  [string]$SqlScriptsUri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/sql.zip",
  
  [string]$AdventureWorksDbUri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/AdventureWorks2012_Data.mdf",
    
  [string]$JreUri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/jre-8u121-windows-x64.exe",

  [string]$AdventureWorksSQLDW2012Uri = "https://bostondata.blob.core.windows.net/edw-data-virtualization/AdventureWorksSQLDW2012.zip",

  [string]$InstallScript = "https://bostondata.blob.core.windows.net/edw-data-virtualization/Install.ps1"
)

function New-Credential([string]$username, [string]$password) {
  $securepw = ConvertTo-SecureString $password -AsPlainText -Force
  return New-Object Management.Automation.PSCredential("$env:COMPUTERNAME\$username", $securepw)
}

function Create-DirIfNotExists([string]$path) {
  if (! (Test-Path $path)) {
    New-Item $path -Type Directory
  }
}

$ENV_PATH = "C:\Windows\Temp\dv-env.json"
$TEMP_INSTALL_PATH = "C:\Windows\Temp\Install.ps1"
$SETUP_DIR = "C:\Tutorial\Setup"

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

Start-Transcript -Path C:\Windows\Temp\dv-deploy.log

$client = New-Object Net.Webclient

@{
  MASTER_KEY = $MasterKey;
  STORAGE_ACCOUNT_NAME = $StorageAccount;
  STORAGE_ACCOUNT_KEY = $StorageKey;
  STORAGE_CONTAINER_NAME = $StorageContainer;
  ADMIN_USER = $AdminUser;
  ADMIN_PASSWORD = $AdminPassword;
  HDI_USERNAME = $AdminUser;
  HDI_PASSWORD = $AdminPassword;
  hadoopHeadnodes = $HadoopHeadnodes;
  sqlServer = $SQLServer;
  sqlDWDatabase = $SQLDWDatabase;
  sqlInstaller = $SQLInstaller;
  polybaseConfigDir = $PolyBaseConfig;
  polybaseConfigUri = $PolyBaseInstallConfigUri;
  mapReduceConfigUri = $MapReduceConfigUri;
  sqlScriptsUri = $SqlScriptsUri;
  adventureWorksUri = $AdventureWorksDbUri;
  jreUri = $JreUri;
  adventureWorksDWUri = $AdventureWorksSQLDW2012Uri;
} | ConvertTo-Json | Out-File $ENV_PATH -Encoding ascii

$client.DownloadFile($InstallScript, $TEMP_INSTALL_PATH)
Create-DirIfNotExists $SETUP_DIR
Copy-Item $TEMP_INSTALL_PATH $SETUP_DIR

Invoke-Command localhost {

  $ws = New-Object -ComObject WScript.Shell
  $shortcut1 = $ws.CreateShortcut("$home\desktop\Setup - Data Virtualization.lnk")
  $shortcut1.TargetPath = "powershell"
  $shortcut1.Arguments = "-ExecutionPolicy Unrestricted -File C:\Tutorial\Setup\Install.ps1"
  $shortcut1.Save()

  
  $shortcut2 = $ws.CreateShortcut("$home\desktop\SQL - Data Virtualization.lnk")
  $shortcut2.TargetPath = "C:\Tutorial"
  $shortcut2.Save()

} -Credential (New-Credential $AdminUser $AdminPassword)

Stop-Transcript