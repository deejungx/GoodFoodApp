using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;

namespace DataAccessLibrary
{
    public interface IConnectionManager
    {
        string ConnString { get; set; }
        Task<List<T>> LoadData<T, TU>(string sql, TU parameters);
        Task SaveData<T>(string sql, T parameters);
        Task<T> GetData<T, TU>(string sql, TU parameters);
    }
}