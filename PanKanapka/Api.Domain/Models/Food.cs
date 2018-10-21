namespace Api.Domain.Models
{
    public class Food
    {
        public string FoodId { get; set; }
        public int Price { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ImageURL { get; set; }
        public bool IsVegan { get; set; }
    }
}
