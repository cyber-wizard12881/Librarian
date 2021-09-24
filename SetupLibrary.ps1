Import-Module 'sqlps'

cd $PSScriptRoot

Write-Host -ForegroundColor Green 'Setting Up the Librarian Project ......'

Write-Host -ForegroundColor Green 'Creating the Database librarian & its associated Tables for the Library Project ......'
Invoke-Sqlcmd -InputFile "$PSScriptRoot/Librarian-000.sql" -ServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -Verbose -ErrorAction 'Stop' -OutputSqlErrors $true -as DataTables
Write-Host -ForegroundColor Green 'Seeding the Database librarian & its associated Tables for the Library Project ......'
Invoke-Sqlcmd -InputFile "$PSScriptRoot/Librarian-001.sql" -ServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -Verbose -ErrorAction 'Stop' -OutputSqlErrors $true -as DataTables
Write-Host -ForegroundColor Green 'Fleshing the Database librarian & its associated Tables with the CLR (C#) Scalar Function Objects for the Library Project ......'
Invoke-Sqlcmd -InputFile "$PSScriptRoot/Librarian-003.sql" -ServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -Variable currDir=$PSScriptRoot -Verbose -ErrorAction 'Stop' -OutputSqlErrors $true -as DataTables

Write-Host -ForegroundColor Green 'SetUp the Librarian Project ......'

cd $PSScriptRoot
