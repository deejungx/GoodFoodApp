using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface IMenuItemData
    {
        Task<List<MenuItemModel>> GetMenuItems();
        Task InsertMenuItem(MenuItemModel menuitem);
        Task DeleteMenuItem(MenuItemModel menuitem);
        Task SaveMenuItem(MenuItemModel menuitem);
        Task<List<MenuItemModel>> GetAllMenuItems();
        Task<List<MenuItemModel>> GetExpandedMenuItems(string searchTerm);
    }
}