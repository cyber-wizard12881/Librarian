Import-Module 'sqlps'

cd $PSScriptRoot

Write-Host -ForegroundColor Green 'Building the Librarian Project ......'

Write-Host -ForegroundColor Green 'Enabling Named Pipes for SqlCommand for SQLEXPRESS 2019 ......'

$smo = 'Microsoft.SqlServer.Management.Smo.'  
$wmi = new-object ($smo + 'Wmi.ManagedComputer').  

$wmi

$uri = "ManagedComputer[@Name='$env:COMPUTERNAME']/ ServerInstance[@Name='SQLEXPRESS']/ServerProtocol[@Name='Np']"  
$Np = $wmi.GetSmoObject($uri)  
$Np.IsEnabled = $true  
$Np.Alter()  
$Np

Write-Host -ForegroundColor Green 'Enabled Named Pipes for SqlCommand for SQLEXPRESS 2019 ......'


Write-Host -ForegroundColor Green 'Stopping Service SQLEXPRESS 2019 ......'
Get-Service -Computer $env:COMPUTERNAME -Name 'MSSQL$SQLEXPRESS' | Stop-Service -Force

Write-Host -ForegroundColor Green 'Starting Service SQLEXPRESS 2019 ......'
Start-Service -Name 'MSSQL$SQLEXPRESS'


Write-Host -ForegroundColor Green 'Built the Librarian Project ......'

cd $PSScriptRoot