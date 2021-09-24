namespace Library
{
    class Program
    {
        static void Main(string[] args)
        {
            Load.Load2Table(@"books.csv", @"librarian", @"dbo.book", @"isbn,name,author,category,price");
            Dump.Dump2File(@"select isbn,name,author,category,price from dbo.book;", @"books.csv");
        }
    }
}
