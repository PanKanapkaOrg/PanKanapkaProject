using System;
using System.Collections.Generic;
using System.Text;

namespace Db.Contracts.Models
{
    public class ReservationDbResult
    {
        public long ReservationId { get; set; }
        public long ClientFirmId { get; set; }
        public bool IsActiveReservation { get; set; }
        public string FoodName { get; set; }
        public short Quantity { get; set; }
        public double PriceTotal { get; set; }
        public string ItemImageUrl { get; set; }
    }
}
