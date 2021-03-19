using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class UserAddressData : IUserAddressData
    {

        private readonly IConnectionManager _db;

        public UserAddressData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<UserAddressModel>> GetUserAddress()
        {
            string sql = @"SELECT
                            useraddress.id, useraddress.longitude, useraddress.latitude, useraddress.city, useraddress.street, useraddress.landmarks,
                            ""User"".id, ""User"".username, ""User"".phone, ""User"".email, ""User"".redeemedloyalty
                           FROM 
                            useraddress
                           INNER JOIN ""User"" ON ""User"".id = useraddress.user_id";

            return _db.GetUserAddresses(sql);
        }

        public Task InsertUserAddress(UserAddressModel address)
        {
            string sql = @"INSERT INTO useraddress (id, longitude, latitude, city, street, landmarks, user_id)
                            VALUES (:Id, :Longitude, :Latitude, :City, :Street, :Landmarks, :UserId)";

            return _db.SaveData(sql, address);
        }

        public Task DeleteUserAddress(UserAddressModel address)
        {
            string sql = @"DELETE FROM useraddress
                            WHERE
                            id = :Id";

            return _db.DeleteData(sql, address);
        }

        public Task SaveUserAddress(UserAddressModel address)
        {
            string sql = @"UPDATE useraddress
                            SET longitude = :Longitude, latitude = :Latitude, city = :City, street = :Street, landmarks = :Landmarks
                            WHERE id = :Id";

            return _db.SaveData(sql, address);
        }
    }
}
