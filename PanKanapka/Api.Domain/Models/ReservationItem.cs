namespace Api.Domain.Models
{
    public class ReservationItem
    {
        public string Name { get; set; }
        public int Quantity { get; set; }
        public double PriceTotal { get; set; }
        public string ItemImageUrl { get; set; }
    }
}
