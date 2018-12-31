using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class TaskCreationItem
    {
        public bool ShouldNotifyWorker { get; set; }
        public string Date { get; set; }
        public long WorkerId { get; set; }
        public IEnumerable<long> ClientFirmIds { get; set; }
    }
}
