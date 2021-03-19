using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface IUserAddressData
    {
        Task<List<UserAddressModel>> GetUserAddress();
        Task InsertUserAddress(UserAddressModel address);
        Task DeleteUserAddress(UserAddressModel address);
        Task SaveUserAddress(UserAddressModel address);
    }
}