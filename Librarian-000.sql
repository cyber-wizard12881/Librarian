use master;

if not exists(select * from sys.databases where name = 'librarian')
begin
create database [librarian];
end
go

use [librarian];
go

drop table dbo.category;
drop table dbo.author;
drop table dbo.book;

if not exists(select * from sysobjects where name = 'book' and type = 'U')
begin	
create table dbo.book
(
 id int primary key identity(1,1),
 isbn nvarchar(12),
 name nvarchar(100),
 author nvarchar(50),
 category nvarchar(20),
 price float
);
end
go

if not exists(select * from sysobjects where name = 'category' and type = 'U')
begin	
create table dbo.category
(
 id int primary key identity(1,1),
 name nvarchar(20)
 );
end
go

if not exists(select * from sysobjects where name = 'author' and type = 'U')
begin	
create table dbo.author
(
 id int primary key identity(1,1),
 name nvarchar(60)
 );
end
go

