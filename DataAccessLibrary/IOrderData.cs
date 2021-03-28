using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface IOrderData
    {
        Task<List<OrderModel>> GetOrders(string searchTerm);
        Task<List<OrderModel>> GetTopRestaurants(string searchTerm);
    }
}