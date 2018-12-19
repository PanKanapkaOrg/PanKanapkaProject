using System;
using System.Collections.Generic;
using System.Text;

namespace Api.Domain.Models
{
    public class ClientFirm
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string LogoUrl { get; set; }
        public IEnumerable<WeekDays> DaysOfWork { get; set; }
    }


    public enum WeekDays
    {
        None,
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday,
        Sunday
    }
}
