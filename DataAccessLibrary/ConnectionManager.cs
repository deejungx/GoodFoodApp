using System;
using System.Collections.Generic;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using DataAccessLibrary.Models;
using Microsoft.Extensions.Configuration;

namespace DataAccessLibrary
{

    public class ConnectionManager : IConnectionManager
    {
        private readonly IConfiguration _config;

        public string ConnString { get; set; } = "Default";

        public ConnectionManager(IConfiguration config)
        {
            _config = config;
        }
        
        public async Task<List<T>> LoadData<T, TU>(string sql, TU parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<T>(sql, parameters);
            return data.ToList();
        }
        
        public async Task SaveData<T>(string sql, T parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            await connection.ExecuteAsync(sql, parameters);
        }
        
        public async Task<T> GetData<T, TU>(string sql, TU parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryFirstAsync<T>(sql, parameters);
            return data;
        }

        public async Task DeleteData<T>(string sql, T parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            await connection.ExecuteAsync(sql, parameters);
        }

        public async Task<List<MenuItemModel>> GetMenuItems(string sql)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            var menuDictionary = new Dictionary<int, MenuItemModel>();

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<MenuItemModel, RestaurantModel, MenuItemModel>(
                sql,
                (menuItem, restaurant) =>
                {
                    MenuItemModel menuEntry;

                    if (!menuDictionary.TryGetValue(menuItem.Id, out menuEntry))
                    {
                        menuEntry = menuItem;
                        menuEntry.Restaurant = new RestaurantModel();
                        menuDictionary.Add(menuEntry.Id, menuEntry);
                    }

                    menuEntry.Restaurant = restaurant;
                    return menuEntry;
                },
                splitOn:"Id");
            return data.ToList();
        }

        public async Task<List<MenuItemModel>> GetExpandedMenuItems<T>(string sql, T parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            var menuDictionary = new Dictionary<int, MenuItemModel>();

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<MenuItemModel, RestaurantModel, DishModel, MenuItemModel>(
                sql,
                (menuItem, restaurant, dish) =>
                {
                    MenuItemModel menuEntry;

                    if (!menuDictionary.TryGetValue(menuItem.Id, out menuEntry))
                    {
                        menuEntry = menuItem;
                        menuEntry.Restaurant = new RestaurantModel();
                        menuEntry.Dish = new DishModel();
                        menuDictionary.Add(menuEntry.Id, menuEntry);
                    }

                    menuEntry.Restaurant = restaurant;
                    menuEntry.Dish = dish;
                    return menuEntry;
                },
                parameters,
                splitOn:"Id");
            return data.ToList();
        }

        public async Task<List<LoyaltyPointsModel>> GetLoyaltyPoints(string sql)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            var pointsDictionary = new Dictionary<int, LoyaltyPointsModel>();

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<LoyaltyPointsModel, MenuItemModel, LoyaltyPointsModel>(
                sql,
                (loyaltyPoints, menuItem) =>
                {
                    LoyaltyPointsModel loyaltyEntry;

                    if (!pointsDictionary.TryGetValue(menuItem.Id, out loyaltyEntry))
                    {
                        loyaltyEntry = loyaltyPoints;
                        loyaltyEntry.Menu = new MenuItemModel();
                        pointsDictionary.Add(loyaltyEntry.Id, loyaltyEntry);
                    }

                    loyaltyEntry.Menu = menuItem;
                    return loyaltyEntry;
                },
                splitOn:"Id");
            return data.ToList();
        }

        public async Task<List<UserAddressModel>> GetUserAddresses(string sql)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            var addressDictionary = new Dictionary<int, UserAddressModel>();

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<UserAddressModel, CustomerModel, UserAddressModel>(
                sql,
                (address, user) =>
                {
                    UserAddressModel addressEntry;

                    if (!addressDictionary.TryGetValue(user.Id, out addressEntry))
                    {
                        addressEntry = address;
                        addressEntry.User = new CustomerModel();
                        addressDictionary.Add(addressEntry.Id, addressEntry);
                    }

                    addressEntry.User = user;
                    return addressEntry;
                },
                splitOn:"Id");
            return data.ToList();
        }

        public async Task<List<OrderModel>> GetOrdersExtended<T>(string sql, T parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            var orderDictionary = new Dictionary<int, OrderModel>();

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<OrderModel, LineItemModel, MenuItemModel, CustomerModel, OrderModel>(
                sql,
                (order, lineItem, menuItem, customer) =>
                {
                    OrderModel orderEntry;

                    if (!orderDictionary.TryGetValue(order.Id, out orderEntry))
                    {
                        orderEntry = order;
                        orderEntry.LineItems = new List<LineItemModel>();
                        orderEntry.User = new CustomerModel();
                        orderDictionary.Add(orderEntry.Id, orderEntry);
                    }

                    orderEntry.LineItems.Add(lineItem);
                    lineItem.MenuItem = menuItem;
                    orderEntry.User = customer;
                    return orderEntry;
                },
                parameters,
                splitOn:"Id");
            return data.ToList();
        }

        public async Task<List<OrderModel>> GetTopRestaurantOrders<T>(string sql, T parameters)
        {
            var connectionString = _config.GetConnectionString(ConnString);
            var orderDictionary = new Dictionary<int, OrderModel>();

            using IDbConnection connection = new OracleConnection(connectionString);
            connection.Open();
            var data = await connection.QueryAsync<OrderModel, LineItemModel, MenuItemModel, CustomerModel, RestaurantModel, OrderModel>(
                sql,
                (order, lineItem, menuItem, customer, restaurant) =>
                {
                    OrderModel orderEntry;

                    if (!orderDictionary.TryGetValue(order.Id, out orderEntry))
                    {
                        orderEntry = order;
                        orderEntry.LineItems = new List<LineItemModel>();
                        orderEntry.User = new CustomerModel();
                        orderDictionary.Add(orderEntry.Id, orderEntry);
                    }

                    orderEntry.LineItems.Add(lineItem);
                    lineItem.MenuItem = menuItem;
                    menuItem.Restaurant = restaurant;
                    orderEntry.User = customer;
                    return orderEntry;
                },
                parameters,
                splitOn:"Id");
            return data.ToList();
        }
    }
    
}
