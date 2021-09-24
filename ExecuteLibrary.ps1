cd $PSScriptRoot

Write-Host -ForegroundColor Green 'Executing the Librarian Project ......'

.\ConceiveLibrary.ps1

.\BuildLibrary.ps1

.\SetupLibrary.ps1

.\OpenLibrary.ps1

.\RunLibrary.ps1

Write-Host -ForegroundColor Green 'Executed the Librarian Project ......'

cd $PSScriptRoot
