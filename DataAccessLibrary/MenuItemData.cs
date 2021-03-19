using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public class MenuItemData : IMenuItemData
    {
        private readonly IConnectionManager _db;

        public MenuItemData(IConnectionManager db)
        {
            _db = db;
        }

        public Task<List<MenuItemModel>> GetMenuItems()
        {
            string sql = @"SELECT id, rate, displayname, dietcategory, description, isavailable
                           FROM menuitem";

            return _db.LoadData<MenuItemModel, dynamic>(sql, new { });
        }

        public Task InsertMenuItem(MenuItemModel menuitem)
        {
            string sql = @"INSERT INTO menuitem (id, rate, displayname, dietcategory, description, isavailable, dish_id, restaurant_id)
                            VALUES (:Id, :Rate, :DisplayName, :DietCategory, :Description, :IsAvailable, :DishId, :RestaurantId)";

            return _db.SaveData(sql, menuitem);
        }

        public Task DeleteMenuItem(MenuItemModel menuitem)
        {
            string sql = @"DELETE FROM menuitem
                            WHERE
                            id = :Id";

            return _db.DeleteData(sql, menuitem);
        }

        public Task SaveMenuItem(MenuItemModel menuitem)
        {
            string sql = @"UPDATE menuitem
                            SET rate = :Rate, displayname = :DisplayName, dietcategory = :DietCategory, description = :Description, isavailable = :IsAvailable
                            WHERE id = :Id";

            return _db.SaveData(sql, menuitem);
        }

        public Task<List<MenuItemModel>> GetAllMenuItems()
        {
            string sql = @"SELECT 
                            menuitem.id, menuitem.rate, menuitem.displayname, menuitem.dietcategory, menuitem.description, menuitem.isavailable,
                            restaurant.id, restaurant.name, restaurant.branch, restaurant.bio, restaurant.phone, restaurant.displayphoto, restaurant.costfortwo, restaurant.city, restaurant.street
                           FROM 
                            menuitem
                           INNER JOIN restaurant ON restaurant.id = menuitem.restaurant_id";

            return _db.GetMenuItems(sql);
        }

        public Task<List<MenuItemModel>> GetExpandedMenuItems(string searchTerm)
        {
            string sql;
            if (string.IsNullOrEmpty(searchTerm))
            {
                sql = @"SELECT 
                            menuitem.id, menuitem.rate, menuitem.displayname, menuitem.dietcategory, menuitem.description, menuitem.isavailable,
                            restaurant.id, restaurant.name, restaurant.branch, restaurant.bio, restaurant.phone, restaurant.displayphoto, restaurant.costfortwo, restaurant.city, restaurant.street,
                            dish.id, dish.code, dish.name
                            FROM 
                            menuitem
                            INNER JOIN restaurant ON restaurant.id = menuitem.restaurant_id
                            INNER JOIN dish ON dish.id = menuitem.dish_id";
            }
            else
            {
                sql = @"SELECT 
                            menuitem.id, menuitem.rate, menuitem.displayname, menuitem.dietcategory, menuitem.description, menuitem.isavailable,
                            restaurant.id, restaurant.name, restaurant.branch, restaurant.bio, restaurant.phone, restaurant.displayphoto, restaurant.costfortwo, restaurant.city, restaurant.street,
                            dish.id, dish.code, dish.name
                            FROM 
                            menuitem
                            INNER JOIN restaurant ON restaurant.id = menuitem.restaurant_id
                            INNER JOIN dish ON dish.id = menuitem.dish_id
                            WHERE menuitem.displayname LIKE :searchTerm
                            OR dish.name LIKE :searchTerm";
            }

            return _db.GetExpandedMenuItems(sql, new { searchTerm = "%" + searchTerm + "%"});
        }
    }
}
