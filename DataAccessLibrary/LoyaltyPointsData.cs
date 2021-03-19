using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class LoyaltyPointsData : ILoyaltyPointsData
    {
        private readonly IConnectionManager _db;

        public LoyaltyPointsData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<LoyaltyPointsModel>> GetAllLoyaltyPoints()
        {
            string sql = @"SELECT
                            loyaltypoint.id, loyaltypoint.points, loyaltypoint.status, loyaltypoint.activefrom, loyaltypoint.activeuntil,
                            menuitem.id, menuitem.rate, menuitem.displayname, menuitem.dietcategory, menuitem.description, menuitem.isavailable
                           FROM 
                            loyaltypoint
                           INNER JOIN menuitem ON menuitem.id = loyaltypoint.menuitem_id";

            return _db.GetLoyaltyPoints(sql);
        }

        public Task InsertLoyaltyPoint(LoyaltyPointsModel loyaltyPoints)
        {
            string sql = @"INSERT INTO loyaltypoint (id, points, status, activefrom, activeuntil, menuitem_id)
                            VALUES (:Id, :Points, :Status, :ActiveFrom, :ActiveUntil, :MenuId)";

            return _db.SaveData(sql, loyaltyPoints);
        }

        public Task DeleteLoyaltyPoint(LoyaltyPointsModel loyaltyPoints)
        {
            string sql = @"DELETE FROM loyaltypoint
                            WHERE
                            id = :Id";

            return _db.DeleteData(sql, loyaltyPoints);
        }

        public Task SaveLoyaltyPoint(LoyaltyPointsModel loyaltyPoints)
        {
            string sql = @"UPDATE loyaltypoint
                            SET points = :Points, status = :Status, activefrom = :ActiveFrom, activeuntil = :ActiveUntil
                            WHERE id = :Id";

            return _db.SaveData(sql, loyaltyPoints);
        }
    }
}
