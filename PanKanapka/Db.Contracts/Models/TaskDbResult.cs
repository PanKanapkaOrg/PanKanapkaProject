using System;
using System.Collections.Generic;
using System.Text;

namespace Db.Contracts.Models
{
    public class TaskDbResult
    {
        /* select w.name, w.surname, t.taskDate, cf.logoUrl, cf.name, cf.address, t.isDone  */
        public long WorkerId { get; set; }
        public string WorkerName { get; set; }
        public string WorkerSurname { get; set; }
        public DateTime TaskDate { get; set; }
        public string LogoUrl { get; set; }
        public string ClientFirmName { get; set; }
        public string Address { get; set; }
        public bool IsDone { get; set; }                
    }
}
