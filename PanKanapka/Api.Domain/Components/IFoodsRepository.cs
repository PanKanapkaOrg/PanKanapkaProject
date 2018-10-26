using Api.Domain.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Api.Domain.Components
{
    public interface IFoodsRepository
    {
        Task<IEnumerable<Food>> GetFoods(string cateringFirmId);
    }
}
