use [librarian];
go

truncate table dbo.category;
truncate table dbo.author;
truncate table dbo.book;

set nocount on;

-- populating categories
insert into dbo.category values
('Fiction'), ('Fantasy'), ('Popular Science'), ('Technology'), ('Self Help'), ('Business'), ('Sport'), ('Glamor'), ('Non Fiction'), ('Kids');
;

declare @a int = 0
--populating authors
while @a < 60
begin
  insert into dbo.author values  (CONCAT_WS(' ', 'Author', round(RAND() * 100,0,0) ));
  set @a = @a + 1;
end;

--populating books
declare @b int = 0;
declare @r int = 0;
declare @c int = 0;
declare @t int = 0;

declare @author nvarchar(60);
declare @category nvarchar(20);
declare @isbn bigint;

while @b < 200
begin
 set @b = @b + 1;
 set @r = ROUND(RAND() * 500, 0 , 0)  
 select @c=count(1) from dbo.category
 select @a=count(1) from dbo.author
 select @author=name from dbo.author where id = @r % @a;
 select @category=name from dbo.category where id = @r % @c;
 select @isbn=round(RAND()* 1000000000000, 0, 0);
 insert into dbo.book values(@isbn, CONCAT_WS(' ','Book', @b), @author, @category, round(rand() * 100, 2, 0));
end;

set nocount off
