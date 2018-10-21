using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class Reservation
    {
        public string ClientFirmId { get; set; }
        public string ReservationId { get; set; }
        public bool IsActiveReservation { get; set; }
        public IEnumerable<ReservationItem> ReservationItems { get; set; }
    }
}
