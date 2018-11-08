using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace Db.Contracts
{
    public class FoodsDbRepository : IFoodsRepository
    {
        IDbConnection dbConn;
        public FoodsDbRepository(IDbConnection dbConnection)
        {
            dbConn = dbConnection;
        }

        public async Task<IEnumerable<Food>> GetFoods(long CateringFirmId)
        {
            string getFoodsQuery = 
                @"select ID as FoodId, price as Price, foodname as Name, fooddescription as Description, 
                imageURL as ImageUrl, isVegan as IsVegan from Foods 
                where cateringFirmID = @CateringFirmId";
            using (dbConn)
            {
                dbConn.Open();

                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

                IEnumerable<Food> foods = dbConn.Query<Food>(getFoodsQuery, new { CateringFirmId });
                return foods;
            }
        }
    }
}
