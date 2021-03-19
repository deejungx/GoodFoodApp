using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class CustomerData : ICustomerData
    {
        private readonly IConnectionManager _db;

        public CustomerData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<CustomerModel>> GetCustomer()
        {
            string sql = @"SELECT id, username, phone, email, redeemedloyalty
                           FROM ""User""";

            return _db.LoadData<CustomerModel, dynamic>(sql, new { });
        }

        public Task InsertCustomer(CustomerModel customer)
        {
            string sql = @"INSERT INTO ""User"" (id, username, phone, email, password, redeemedloyalty)
                            VALUES (:Id, :Username, :Phone, :Email, :Password, :RedeemedLoyalty)";

            return _db.SaveData(sql, customer);
        }

        public Task DeleteCustomer(CustomerModel customer)
        {
            string sql = @"DELETE FROM ""User""
                            WHERE
                            id = :Id";

            return _db.DeleteData(sql, customer);
        }

        public Task SaveCustomer(CustomerModel customer)
        {
            string sql = @"UPDATE ""User""
                            SET username = :Username, phone = :Phone, email = :Email, redeemedloyalty = :RedeemedLoyalty
                            WHERE id = :Id";

            return _db.SaveData(sql, customer);
        }
    }
}
