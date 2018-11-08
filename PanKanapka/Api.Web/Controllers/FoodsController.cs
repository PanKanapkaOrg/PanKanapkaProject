using System.Collections.Generic;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FoodsController : Controller
    {
        private IFoodsRepository _foodsRepository;
        public FoodsController(IFoodsRepository foodsRepository)
        {
            _foodsRepository = foodsRepository;       
        }

        [HttpGet("{cateringFirmId}")]
        public async Task<IEnumerable<Food>> GetFoods(long cateringFirmId)
        {
            return await _foodsRepository.GetFoods(cateringFirmId);
        }
    }
}