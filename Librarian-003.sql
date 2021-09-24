use librarian;  
go

sp_configure 'show advanced options', 1
RECONFIGURE
GO

sp_configure 'clr enabled', 1
GO  
RECONFIGURE  
GO 

sp_configure 'clr strict security', 0
GO  
RECONFIGURE  
GO 

ALTER DATABASE librarian SET TRUSTWORTHY ON; 


  
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'Load2Table')  
   DROP FUNCTION Load2Table;  
go  

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'Dump2File')  
   DROP FUNCTION Dump2File;  
go

declare @librarian_hash varbinary(64);
select @librarian_hash=hash from sys.trusted_assemblies where description='Librarian';
exec sp_drop_trusted_assembly @hash=@librarian_hash;
go
  
IF EXISTS (SELECT name FROM sys.assemblies WHERE name = 'Librarian')  
   DROP ASSEMBLY Librarian;  
go  
  
CREATE ASSEMBLY Librarian 
FROM '$(currDir)\\Librarian\\obj\\MCD\\Release\\net48\\Librarian.dll'  
WITH PERMISSION_SET = EXTERNAL_ACCESS;  
GO 

declare @librarian_hash varbinary(64);
declare @librarian nvarchar(4000);
declare @librarian_bin varbinary(max);

select @librarian=name from sys.assemblies where name = 'Librarian';
select @librarian_bin=content from sys.assembly_files where name like '%Librarian%';

select @librarian_hash=HASHBYTES('SHA2_512', @librarian_bin);

exec sp_add_trusted_assembly @hash=@librarian_hash, @description=@librarian;
go
  
CREATE FUNCTION Load2Table(@file nvarchar(max), @database nvarchar(max),@table nvarchar(max),@columns nvarchar(max))   
RETURNS INT WITH EXECUTE AS OWNER
AS EXTERNAL NAME Librarian.[Load].[Load2Table];  
go  

CREATE FUNCTION Dump2File(@sqlCommand nvarchar(max), @file nvarchar(max))   
RETURNS INT WITH EXECUTE AS OWNER
AS EXTERNAL NAME Librarian.[Dump].[Dump2File];  
go 
 