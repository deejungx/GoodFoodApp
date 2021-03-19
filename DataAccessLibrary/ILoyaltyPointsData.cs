using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface ILoyaltyPointsData
    {
        Task<List<LoyaltyPointsModel>> GetAllLoyaltyPoints();
        Task InsertLoyaltyPoint(LoyaltyPointsModel loyaltyPoints);
        Task DeleteLoyaltyPoint(LoyaltyPointsModel loyaltyPoints);
        Task SaveLoyaltyPoint(LoyaltyPointsModel loyaltyPoints);
    }
}