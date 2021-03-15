using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class DishData : IDishData
    {
        private readonly IConnectionManager _db;

        public DishData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<DishModel>> GetDish()
        {
            string sql = "SELECT id, code, name FROM dish";

            return _db.LoadData<DishModel, dynamic>(sql, new { });
        }

        public Task InsertDish(DishModel dish)
        {
            string sql = @"INSERT INTO dish (id, code, name)
                            VALUES (:Id, :Code, :Name)";

            return _db.SaveData(sql, dish);
        }

        public Task DeleteDish(DishModel dish)
        {
            string sql = @"DELETE FROM dish
                            WHERE
                            id = :Id";

            return _db.DeleteData(sql, dish);
        }

        public Task SaveDish(DishModel dish)
        {
            string sql = @"UPDATE dish
                            SET code = :Code, name = :Name
                            WHERE id = :Id";

            return _db.SaveData(sql, dish);
        }
    }
}
