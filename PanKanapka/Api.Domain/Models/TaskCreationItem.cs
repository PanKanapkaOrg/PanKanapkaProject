using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class TaskCreationItem
    {
        public string Date { get; set; }
        public string WorkerId { get; set; }
        public IEnumerable<string> ClientFirmIds { get; set; }
    }
}
