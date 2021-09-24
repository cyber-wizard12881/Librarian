cd $PSScriptRoot

Write-Host -ForegroundColor Green 'Opening the Librarian Project ......'

$Acl = Get-Acl "$PSScriptRoot\\Books"

$ar = new-object system.security.accesscontrol.filesystemaccessrule('nt service\mssql$sqlexpress', "fullcontrol", "containerinherit,objectinherit", "none", "allow")

$acl.setaccessrule($ar)
set-acl "$PSScriptRoot\\Books" $acl

Write-Host -ForegroundColor Green "Access Granted to Folder $PSScriptRoot\Books for MS SQL Server 2019 ....."

Write-Host -ForegroundColor Green 'Opened the Librarian Project ......'

cd $PSScriptRoot
