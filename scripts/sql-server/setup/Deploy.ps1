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

$ENV_PATH = "C:\Windows\Temp\dv-env.json"
$TEMP_INSTALL_PATH = "C:\Windows\Temp\Install.ps1"
$SETUP_DIR = "C:\Tutorial\Setup"

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

Start-Transcript -Path C:\Windows\Temp\dv-deploy.log

$client = New-Object Net.Webclient

@{
  MasterKey = $MasterKey;
  StorageAccount = $StorageAccount;
  StorageKey = $StorageKey;
  StorageContainer = $StorageContainer;
  AdminUser = $AdminUser;
  AdminPassword = $AdminPassword;
  HadoopHeadnodes = $HadoopHeadnodes;
  SqlServer = $SQLServer;
  SqlDWDatabase = $SQLDWDatabase;
  SqlInstaller = $SQLInstaller;
  PolybaseConfigDir = $PolyBaseConfig;
  PolybaseConfigUri = $PolyBaseInstallConfigUri;
  MapReduceConfigUri = $MapReduceConfigUri;
  SqlScriptsUri = $SqlScriptsUri;
  AdventureWorksUri = $AdventureWorksDbUri;
  JreUri = $JreUri;
  AdventureWorksDWUri = $AdventureWorksSQLDW2012Uri;
} | ConvertTo-Json | Out-File $ENV_PATH -Encoding ascii

$client.DownloadFile($InstallScript, $TEMP_INSTALL_PATH)

if (! (Test-Path $SETUP_DIR)) {
  New-Item $SETUP_DIR -Type Directory
}

Copy-Item $TEMP_INSTALL_PATH $SETUP_DIR

Stop-Transcript