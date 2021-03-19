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

        public Task InsertRestaurant(RestaurantModel restaurant)
        {
            string sql = @"INSERT INTO restaurant (id, name, branch, bio, phone, displayphoto, costfortwo, city, street)
                            VALUES (:Id, :Name, :Branch, :Bio, :Phone, empty_blob(), :CostForTwo, :City, :Street)";

            return _db.SaveData(sql, restaurant);
        }

        public Task DeleteRestaurant(RestaurantModel restaurant)
        {
            string sql = @"DELETE FROM restaurant
                            WHERE
                            id = :Id";

            return _db.DeleteData(sql, restaurant);
        }

        public Task SaveRestaurant(RestaurantModel restaurant)
        {
            string sql = @"UPDATE restaurant
                            SET name = :Name, branch = :Branch, phone = :Phone, costfortwo = :CostForTwo, city = :City, street = :Street
                            WHERE id = :Id";

            return _db.SaveData(sql, restaurant);
        }
    }
}
