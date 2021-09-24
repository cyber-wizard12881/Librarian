cd $PSScriptRoot

Write-Host -ForegroundColor Green 'Running the Librarian Project ......'

Write-Host -ForegroundColor Green 'Creating the Database librarian & its associated Tables for the Library Project ......'
Invoke-Sqlcmd -InputFile "$PSScriptRoot/Librarian-004.sql" -ServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -Variable currDir=$PSScriptRoot -Verbose -ErrorAction 'Stop' -OutputSqlErrors $true -as DataTables

Write-Host -ForegroundColor Green 'Ran the Librarian Project ......'

cd $PSScriptRoot
