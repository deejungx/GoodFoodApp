using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class OrderData : IOrderData
    {
        private readonly IConnectionManager _db;

        public OrderData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<OrderModel>> GetOrders(string searchTerm)
        {
            string sql;
            if (string.IsNullOrEmpty(searchTerm))
            {
                sql =
                    @"SELECT ""Order"".id, ""Order"".serialnumber, ""Order"".ordertotal, ""Order"".orderstatus, ""Order"".paymentstatus, ""Order"".creationdate, ""Order"".loyaltyscore,
                            lineitem.id, lineitem.quantity, lineitem.itemtotal,
                            menuitem.id, menuitem.displayname, menuitem.description, menuitem.rate,
                            ""User"".id, ""User"".username, ""User"".phone, ""User"".email, ""User"".redeemedloyalty
                            FROM ""Order""
                            INNER JOIN lineitem ON lineitem.order_id = ""Order"".id
                            INNER JOIN ""User"" ON ""User"".id = ""Order"".user_id
                            INNER JOIN menuitem ON menuitem.id = lineitem.menuitem_id";
            }
            else
            {
                sql =
                    @"SELECT ""Order"".id, ""Order"".serialnumber, ""Order"".ordertotal, ""Order"".orderstatus, ""Order"".paymentstatus, ""Order"".creationdate, ""Order"".loyaltyscore,
                            lineitem.id, lineitem.quantity, lineitem.itemtotal,
                            menuitem.id, menuitem.displayname, menuitem.description, menuitem.rate,
                            ""User"".id, ""User"".username, ""User"".phone, ""User"".email, ""User"".redeemedloyalty
                            FROM ""Order""
                            INNER JOIN lineitem ON lineitem.order_id = ""Order"".id
                            INNER JOIN ""User"" ON ""User"".id = ""Order"".user_id
                            INNER JOIN menuitem ON menuitem.id = lineitem.menuitem_id
                            WHERE ""User"".username LIKE :searchTerm";
            }

            return _db.GetOrdersExtended(sql, new { searchTerm = "%" + searchTerm + "%"});
        }

        public Task<List<OrderModel>> GetTopRestaurants(string searchTerm)
        {
            var sql = @"SELECT * FROM
                            (SELECT
                                restaurant.name, COUNT(lineitem.quantity) dish_qty
                            FROM ""Order""
                            INNER JOIN ""User"" ON ""User"".id = ""Order"".user_id
                            INNER JOIN lineitem ON lineitem.order_id = ""Order"".id
                            INNER JOIN menuitem ON menuitem.id = lineitem.menuitem_id
                            INNER JOIN restaurant ON restaurant.id = menuitem.restaurant_id
                            WHERE 
                                ""Order"".creationdate > TO_TIMESTAMP( '02/18/2021 14:00:00', 'MM-DD-YYYY HH24:MI:SS')
                            AND
                                ""User"".username LIKE :searchTerm
                            GROUP BY
                                restaurant.name
                            ORDER BY
                                dish_qty DESC)
                        WHERE ROWNUM <= 5";

            return _db.GetTopRestaurantOrders(sql, new { searchTerm = "%" + searchTerm + "%"});
        }
    }
}
