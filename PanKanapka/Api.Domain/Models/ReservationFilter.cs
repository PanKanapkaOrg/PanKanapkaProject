using System;
using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class ReservationFilter
    {
        public long CateringFirmId { get; set; }
        public IEnumerable<long> ClientFirmIds { get; set; }
        public DateTime Date { get; set; }
    }
}
