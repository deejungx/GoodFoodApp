using System.Collections.Generic;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Extensions.Configuration;

namespace DataAccessLibrary
{

    public class ConnectionManager : IConnectionManager
    {
        private readonly IConfiguration _config;

        public string ConnString { get; set; } = "Default";

        public ConnectionManager(IConfiguration config)
        {
            _config = config;
        }
        
        public async Task<List<T>> LoadData<T, TU>(string sql, TU parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<T>(sql, parameters);
            return data.ToList();
        }
        
        public async Task SaveData<T>(string sql, T parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            await connection.ExecuteAsync(sql, parameters);
        }
        
        public async Task<T> GetData<T, TU>(string sql, TU parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryFirstAsync<T>(sql, parameters);
            return data;
        }
    }
    
}
