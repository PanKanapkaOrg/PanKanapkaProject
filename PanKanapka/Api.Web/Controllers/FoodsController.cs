using System.Collections.Generic;
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FoodsController : Controller
    {
        [HttpGet("{cateringFirmId}")]
        public IEnumerable<Food> GetFoods(string cateringFirmId)
        {
            return new List<Food>
            {
                new Food()
                {
                    FoodId = 1,
                    Price = 4.67,
                    Name = "bulka",
                    Description = null,
                    ImageURL = null,
                    IsVegan = true
                },
                new Food()
                {
                    FoodId = 2,
                    Price = 1.87,
                    Name = "chleb",
                    Description = null,
                    ImageURL = null,
                    IsVegan = false
                }
            };
        }
    }
}