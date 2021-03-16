using DataAccessLibrary.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DataAccessLibrary
{
    public class RestaurantData : IRestaurantData
    {
        private readonly IConnectionManager _db;

        public RestaurantData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<RestaurantModel>> GetRestaurant()
        {
            string sql = @"SELECT id, name, branch, bio, phone, displayphoto, costfortwo, city, street
                           FROM restaurant";

            return _db.LoadData<RestaurantModel, dynamic>(sql, new { });
        }
    }
}
