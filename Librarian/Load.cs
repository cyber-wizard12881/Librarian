using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Data.SqlClient;
using System.IO;

public class Load
{
    [SqlFunction(DataAccess = DataAccessKind.Read, SystemDataAccess = SystemDataAccessKind.Read)]
    public static SqlInt32 Load2Table(SqlString file, SqlString database, SqlString table, SqlString columns)
    {
        int count = 0;
        List<Tuple<SqlString, SqlInt32, SqlString>> rowSchema = new List<Tuple<SqlString, SqlInt32, SqlString>>();

        string[] lines = File.ReadAllLines(Path.GetFullPath(file.Value));
        string[] records = new string[lines.Length];
        string[] colNames = columns.Value.Split(',');

        using (SqlConnection connection = new SqlConnection(
            @"Server=localhost\SQLEXPRESS;Database=librarian;Trusted_Connection=True;"))
        {
            connection.Open();

            using (SqlCommand command = new SqlCommand($@"select sac.name, sac.column_id, st.name from sys.all_columns sac
inner join sys.types st
on st.user_type_id = sac.user_type_id
where object_id = (select object_id from sys.tables where name = 'book');", connection))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        SqlString columnName = reader.GetSqlString(0);
                        SqlInt32 columnOrder = reader.GetSqlInt32(1);
                        SqlString columnType = reader.GetSqlString(2);
                        rowSchema.Add(Tuple.Create(columnName, columnOrder, columnType));
                    }
                }
            }

            

            for (int jdx = 0; jdx < lines.Length; jdx++)
            {
                string[] words = lines[jdx].Split(',');

                for (int kdx = 0; kdx < words.Length; kdx++)
                {
                    Tuple<SqlString, SqlInt32, SqlString> cols = rowSchema.Find(c => c.Item1.Value.Equals(colNames[kdx]));

                    if (cols.Item3.Value.Equals("nvarchar") || cols.Item3.Value.Equals("varchar"))
                    {
                        words[kdx] = $"'{words[kdx]}'";
                    }
                }
                records[jdx] = $"({string.Join(",", words)})";
            }

            string sqlCommand = $@"use {database};
set nocount on;
insert into {table} ({columns}) values {string.Join(",", records)};
set nocount off;";


            using (SqlCommand command = new SqlCommand($@"{sqlCommand}", connection))
            {
                count = command.ExecuteNonQuery();
            }
        }
        return count;
    }
}
