using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface ICustomerData
    {
        Task<List<CustomerModel>> GetCustomer();
        Task InsertCustomer(CustomerModel customer);
        Task DeleteCustomer(CustomerModel customer);
        Task SaveCustomer(CustomerModel customer);
    }
}