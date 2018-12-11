using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class Reservation
    {
        public long ReservationId { get; set; }
        public long ClientFirmId { get; set; }
        public bool IsActiveReservation { get; set; }
        public IEnumerable<ReservationItem> ReservationItems { get; set; }
    }

    public class ReservationItem
    {
        public string Name { get; set; }
        public int Quantity { get; set; }
        public double PriceTotal { get; set; }
        public string ItemImageUrl { get; set; }
    }


    public class ClientReservation
    {
        public long ReservationId { get; set; }
        public CateringFirm cateringFirm { get; set; }
        public bool IsActiveReservation { get; set; }
        public string Name { get; set; }
        public int Quantity { get; set; }
        public double PriceTotal { get; set; }
        public string ItemImageUrl { get; set; }
    }

    public class CateringFirm
    {
    }
}
