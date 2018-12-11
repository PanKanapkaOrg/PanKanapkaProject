using System;
using System.Collections.Generic;
using System.Text;

namespace Api.Domain.Models
{
    public class Login
    {
        public long Id { get; set; }
        public long AuthId { get; set; }
        public long FirmId { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public string Role { get; set; }
    }
}
