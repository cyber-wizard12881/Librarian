using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.Data.SqlClient;
using System.IO;

public class Dump
{
    [SqlFunction(DataAccess = DataAccessKind.Read, SystemDataAccess = SystemDataAccessKind.Read)]
    public static SqlInt32 Dump2File(SqlString sqlCommand, SqlString file)
    {
        List<string> resultSet = new List<string>();
        List<Tuple<SqlString, SqlInt32, SqlString>> rowSchema = new List<Tuple<SqlString, SqlInt32, SqlString>>();


        using (SqlConnection connection = new SqlConnection(@"Server=localhost\SQLEXPRESS;Database=librarian;Trusted_Connection=True;"))
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

            using (SqlCommand command = new SqlCommand($@"{sqlCommand}", connection))
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        object[] row = new object[reader.FieldCount];
                        string[] colValues = new string[reader.FieldCount];
                        reader.GetValues(row);
                        resultSet.Add(string.Join(",", row));
                    }
                }
            }
        }

        File.WriteAllLines(Path.GetFullPath(file.Value), resultSet);
            
        return resultSet.Count;
    }
}
