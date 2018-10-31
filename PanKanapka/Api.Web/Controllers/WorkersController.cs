using System.Collections.Generic;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    public class WorkersController : Controller
    {
        private IWorkersRepository _workerRepository;

        public WorkersController()
        {
            _workerRepository = new FakeWorkers();
        }

        [HttpGet("/api/[controller]/{cateringFirmId}")]
        public async Task<IEnumerable<Worker>> GetWorkersAsync(long cateringFirmId)
        {
            return await _workerRepository.GetWorkers(cateringFirmId);
        }
    }

    class FakeWorkers : IWorkersRepository
    {
        public Task<IEnumerable<Worker>> GetWorkers(long cateringFirmId)
        {
            IEnumerable<Worker> workers = new List<Worker>();

            return Task.FromResult(workers);
        }
    }
}