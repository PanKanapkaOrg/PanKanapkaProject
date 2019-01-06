using System;
using System.Collections.Generic;
using System.Text;

namespace Api.Domain.Models
{
    public class WorkerAddingData
    {
        public int cateringFirmId { get; set; }
        public string name { get; set; }
        public string surname { get; set; }
        public string mail { get; set; }
        public string password { get; set; }
    }
}
