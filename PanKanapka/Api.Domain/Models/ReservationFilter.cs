using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class ReservationFilter
    {
        public string CateringFirmId { get; set; }
        public IEnumerable<string> ClientFirmsId { get; set; }
        public string Date { get; set; }
    }
}
