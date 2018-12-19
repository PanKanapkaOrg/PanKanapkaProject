using System;
using System.Collections.Generic;
using System.Text;

namespace Db.Contracts.Models
{
    public class TaskDbResult
    {
        public long? ClientFirmID { get; set; }
        public long? WorkerId { get; set; }
        public string WorkerName { get; set; }
        public string WorkerSurname { get; set; }
        public DateTime? TaskDate { get; set; }
        public string LogoUrl { get; set; }
        public string ClientFirmName { get; set; }
        public string Address { get; set; }
        public bool? IsDone { get; set; }
        public long? TaskId { get; set; }
    }
}
