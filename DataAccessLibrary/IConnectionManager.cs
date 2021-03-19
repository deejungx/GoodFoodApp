using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface IConnectionManager
    {
        string ConnString { get; set; }
        Task<List<T>> LoadData<T, TU>(string sql, TU parameters);
        Task SaveData<T>(string sql, T parameters);
        Task<T> GetData<T, TU>(string sql, TU parameters);
        Task DeleteData<T>(string sql, T parameters);
        Task<List<MenuItemModel>> GetMenuItems(string sql);
        Task<List<LoyaltyPointsModel>> GetLoyaltyPoints(string sql);
        Task<List<UserAddressModel>> GetUserAddresses(string sql);
        Task<List<MenuItemModel>> GetExpandedMenuItems<T>(string sql, T parameters);
    }
}