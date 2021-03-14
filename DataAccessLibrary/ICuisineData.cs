﻿using System.Collections.Generic;
using System.Threading.Tasks;
using DataAccessLibrary.Models;

namespace DataAccessLibrary
{
    public interface ICuisineData
    {
        Task<List<CuisineModel>> GetCuisine();
        Task InsertCuisine(CuisineModel cuisine);
    }
}