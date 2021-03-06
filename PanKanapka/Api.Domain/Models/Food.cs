﻿namespace Api.Domain.Models
{
    public class Food
    {
        public long FoodId { get; set; }
        public double Price { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ImageURL { get; set; }
        public bool IsVegan { get; set; }
    }
}
