using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class Worker
    {
        public string Name { get; set; }
        public string Surname { get; set; }
    }


    public class Task
    {
        public Worker Worker { get; set; }
        public IEnumerable<TaskItem> TaskItems { get; set; }
    }
    
}
