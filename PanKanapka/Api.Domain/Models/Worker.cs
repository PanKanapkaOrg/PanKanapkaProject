using System.Collections.Generic;

namespace Api.Domain.Models
{
    public class Worker
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        

        public override bool Equals(object obj)
        {
            if (obj == null)
                return false;

            if (obj is Worker worker)
            {
                return Id == worker.Id;
            }
            return false;
        }

        public override int GetHashCode()
        {
            var hashCode = -129878884;
            hashCode = hashCode * -1521134295 + Id.GetHashCode();
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Name);
            hashCode = hashCode * -1521134295 + EqualityComparer<string>.Default.GetHashCode(Surname);
            return hashCode;
        }
    }

}
