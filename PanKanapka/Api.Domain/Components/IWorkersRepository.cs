using System.Collections.Generic;
using Api.Domain.Models;

namespace Api.Domain.Components
{
    public interface IWorkersRepository
    {
        System.Threading.Tasks.Task<IEnumerable<Worker>> GetWorkers(long cateringFirmId);
        System.Threading.Tasks.Task AddWorker(string name, string surname, long cateringFirmId, string email, string password);
    }
}
