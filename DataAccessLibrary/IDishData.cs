using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface IDishData
    {
        Task<List<DishModel>> GetDish();
        Task InsertDish(DishModel dish);
        Task DeleteDish(DishModel dish);
        Task SaveDish(DishModel dish);
    }
}