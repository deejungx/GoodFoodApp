using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class OrderData
    {
        private readonly IConnectionManager _db;

        public OrderData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<OrderModel>> GetOrders()
        {
            string sql = @"SELECT ""Order"".id, ""Order"".serialnumber, ""Order"".ordertotal, ""Order"".orderstatus, ""Order"".paymentstatus, ""Order"".creationdate, ""Order"".loyaltyscore,
                            lineitem.id, lineitem.quantity, lineitem.itemtotal, lineitem.menuitem_id,
                            ""User"".id, ""User"".username, ""User"".phone, ""User"".email, ""User"".redeemedloyalty
                            FROM ""Order""
                            INNER JOIN lineitem ON lineitem.order_id = ""Order"".id
                            INNER JOIN ""User"" ON ""User"".id = ""Order"".user_id";

            return _db.LoadData<OrderModel, dynamic>(sql, new { });
        }
    }
}
