using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class Reservation
    {
        public long ClientFirmId { get; set; }
        public long ReservationId { get; set; }
        public bool IsActiveReservation { get; set; }
        public IEnumerable<ReservationItem> ReservationItems { get; set; }
    }
}
