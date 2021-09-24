use librarian;
go

begin try
SELECT dbo.Load2Table('$(currDir)\\Books\\books.csv', 'librarian', 'dbo.book', 'isbn,name,author,category,price');  
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
end catch;
go 

begin try
SELECT dbo.Dump2File('select isbn,name,author,category,price from dbo.book;', '$(currDir)\\Books\\books.csv');  
end try
begin catch
    SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
end catch;
go