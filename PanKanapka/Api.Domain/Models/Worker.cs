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
    }

}
