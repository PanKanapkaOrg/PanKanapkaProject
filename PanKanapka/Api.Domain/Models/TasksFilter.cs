using System;
using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class TasksFilter
    {
        public IEnumerable<long> WorkerIds { get; set; }
        public DateTime Date { get; set; }
        public int DaysBefore { get; set; }
        public int DaysAfter { get; set; }
    }
}
