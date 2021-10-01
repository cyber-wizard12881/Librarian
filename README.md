# Librarian
CLR Scalar Functions in C# to Integrate with SQL Server 2019 Express

## Who's a Librarian, anyways?  
Before Computers, in olden days, there were only Books as the premier means of written Communication. Libraries were the old Gargantuan Knowledgebases and Storehouses of Intellectual Property. <br/>
I remember how people flocked to Bookshops & Libraries to quench their thirst of Knowledge. <br/>
Librarians were of course, the Curators & Book-Keepers in Libraries. Just like money-lenders, they used to manage the transactions of Books to People in Libraries.<br/>
That makes Librarians the Key Custodians & Guardians of the Powerhouses of knowledge. <br/>

## But, Why a Librarian?
The terms like Libraries, Indexes, Pages, Sections, Lines, Words & Characters are all synonymous with Computing! They are just beautifully disguised metaphors of the Language. And the Volumes can be published and written in a wide variety of Languages!!! .... :-) <br/>
Personally, I like to write & it's not just code .... <br/>
So, would love to be surrounded by Books & hence the name stuck with Librarian!! <br/>

## What is this Project about?
In Simple Terms about Importing & Exporting Data to a DB & a Csv File. It's as simple as that! <br/>

## What's the Tech-Stack?
1. Microsoft SQL Server 2019 Express
2. C# in .NET 4.8
3. PowerShell to tie the loose ends together.... to bind the Catalog if you may say!! <br/>
And, of course,
4. Visual Studio 2019 Community Edition for the IDE! <br/>

## Okay, how do I set things up? And, most importantly, get it Running?
It is as simple as ```./ExecuteLibrary.ps1``` <br/>

## What's happening under the Hood?
It calls & orchestrates the following....
1. Builds & Compiles the C# Library called 'Librarian'.
2. Enables Named Pipes on the Local Computer for Invoking SqlCmd from the Scripts!<br/>
3. Restarts SQL Server 2019 Express after that.
4. Grants Sql Server access to the Folder where the Csv resides ... needed to write and access the Csv from the UDF in the DB.
5. Sets up the DB if it doesn't exist, already.
6. Creates the relevant tables.
7. Fleshes the Data in the Tables.
8. Drops (if exists...) & Registers the UDF (C#) dll with SQL Server 2019 Express.
9. Invokes the Dump2File() UDF which dumps data from dbo.books to write to a csv file.
10. Invokes the Load2Table() UDF which reads the data from that csv & writes back to the dbo.books table. <br/>
<u>P.S</u>: The UDFs are Scalar Valued & written in C# .NET 4.8 Framework as currently .NET 5 or 6 does not support UDFs on SQL Server 2019 (Windows).

## What's next?
Have a look at the code ....
1. Esp. the C# Files (.cs) to see the attributes/annotations to create UDFs with SQL Server 2019.
2. The Sql (.sql) Files to see the randomization do wonders to create books in our library! And, how the parameters get passed & interpolated in the Sql files from SqlCmd!
3. The Ps1 (for PowerShell and not Postscript which is .ps!) Files to bind all things together!
4. The Library Project which you can execute from Visual Studio 2019 to see things in action!
5. The Books folder which contains a Bootstrapping Csv File to get things started in the Library!

## Wow! That's Fabulous!
YES. To see the 2-way Sync between a Csv File & a Table in the DB is indeed Magical!

## That's it! It's your turn to Write .....
Now that you've read this ... I hope that you will find the Journey thru' the Mystical Library truly Interesting & Inspiring.
For that's what Good Writers are made of!!! <br/>
So go through the Code and Create your Own Library!!! <br/>

## Conclusion:
The Load & Dump of Data to & from the SQL Server Table & a Csv File on the Disk via C# CLR UDFs was Successful!! <br/>
The Prime motive was the ease of use & extensibility of the UDFs that were created!!!!

## Future Scope:
<u>Caveats:</u> The Perf Tests might show up pretty surprising & Interesting results for I have loaded data mostly in a few MBs ... to make this more robust & scalable is challenging!!! <br/>

But, that's a different story altogether!

## Thanks!!!
Hope this Repository proved a handful for the vast cornucopia of knowledge needs to be tapped .... and this is just the tip of the iceberg! Cool....!! <br/>
With this I call it a wrap!!! <br/>
And of course ... Yes .... <br/>
Happy Coding!!!! <br/>
