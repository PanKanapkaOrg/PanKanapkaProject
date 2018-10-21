﻿using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class TasksFilter
    {
        public string CateringFirmId { get; set; }
        public IEnumerable<string> WorkerIds { get; set; }
        public string Date { get; set; }
        public int DaysBefore { get; set; }
        public int DaysAfter { get; set; }
    }
}
