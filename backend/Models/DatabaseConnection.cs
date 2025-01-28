using Npgsql;

namespace backend.Models
{
    public class DatabaseConnection
    {

        private readonly string connectionString = "Host=localhost;Port=5432;Database=Flashcards;Username=admin;Password=admin;";
        private readonly NpgsqlDataSource dataSource;

        public DatabaseConnection()
        {
            dataSource = NpgsqlDataSource.Create(connectionString);
        }

        public NpgsqlConnection GetConnection()
        {
            return dataSource.OpenConnection();
        }

        public List<Dictionary<string, object>> SelectAllFromTable(string tableName)
        {
            var results = new List<Dictionary<string, object>>();

            using (var connection = GetConnection())
            {
                var query = $"SELECT * FROM {tableName}";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var row = new Dictionary<string, object>();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                row[reader.GetName(i)] = reader.GetValue(i);
                            }
                            results.Add(row);
                        }
                    }
                }
            }

            return results;
        }

    }
}
