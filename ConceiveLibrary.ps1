cd $PSScriptRoot

Write-Host -ForegroundColor Green 'Building the CLR (C#) Scalar Function Objects for the Librarian Project as a part of the Conception Stage ......'

cd Librarian

Get-ChildItem .\ -include bin,obj -Recurse | foreach ($_) { remove-item $_.fullname -Force -Recurse }
dotnet clean
dotnet build --configuration Release

Write-Host -ForegroundColor Green 'Built the CLR (C#) Scalar Function Objects for the Librarian Project as a part of the Conception Stage ......'

cd $PSScriptRoot
