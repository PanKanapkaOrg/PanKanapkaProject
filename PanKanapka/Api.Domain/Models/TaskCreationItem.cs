using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class TaskCreationItem
    {
        public string Date { get; set; }
        public long WorkerId { get; set; }
        public IEnumerable<long> ClientFirmIds { get; set; }
    }
}
