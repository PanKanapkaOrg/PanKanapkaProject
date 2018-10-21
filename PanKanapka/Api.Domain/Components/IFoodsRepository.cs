using Api.Domain.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Api.Domain.Components
{
    public interface IFoodsRepository
    {
        IEnumerable<Food> GetFoods(string cateringFirmId);
    }
}
