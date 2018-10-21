using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class FirmTask
    {
        public string LogoUrl { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public bool IsActiveTask { get; set; }
    }

    public class TaskItem
    {
        public string Date { get; set; }
        public IEnumerable<FirmTask> Firms { get; set; }
    }
}
