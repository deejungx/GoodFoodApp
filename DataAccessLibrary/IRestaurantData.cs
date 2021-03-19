using DataAccessLibrary.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DataAccessLibrary
{
    public interface IRestaurantData
    {
        Task<List<RestaurantModel>> GetRestaurant();
        Task InsertRestaurant(RestaurantModel restaurant);
        Task DeleteRestaurant(RestaurantModel restaurant);
        Task SaveRestaurant(RestaurantModel restaurant);
    }
}