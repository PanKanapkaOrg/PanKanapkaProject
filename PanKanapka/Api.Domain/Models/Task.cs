using System;
using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class WorkerTask
    {
        public Worker Worker { get; set; }
        public IEnumerable<TaskItem> TaskItems { get; set; }
    }

    public class FirmTask
    {
        public long TaskId { get; set; }
        public long Id { get; set; }
        public string LogoUrl { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public bool IsActiveTask { get; set; }
    }

    public class TaskItem
    {
        public DateTime Date { get; set; }
        public IEnumerable<FirmTask> Firms { get; set; }
    }
}
