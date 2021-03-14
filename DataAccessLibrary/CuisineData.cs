using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class CuisineData : ICuisineData
    {
        private readonly IConnectionManager _db;

        public CuisineData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<CuisineModel>> GetCuisine()
        {
            string sql = "SELECT id, name, description FROM cuisine";

            return _db.LoadData<CuisineModel, dynamic>(sql, new { });
        }

        public Task InsertCuisine(CuisineModel cuisine)
        {
            string sql = @"INSERT INTO cuisine (id, name, description)
                            VALUES (:Id, :Name, :Description)";

            return _db.SaveData(sql, cuisine);
        }
    }
}
