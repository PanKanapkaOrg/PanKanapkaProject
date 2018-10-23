using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class ReservationFilter
    {
        public string CateringFirmId { get; set; }
        public IEnumerable<string> ClientFirmIds { get; set; }
        public string Date { get; set; }
    }
}
