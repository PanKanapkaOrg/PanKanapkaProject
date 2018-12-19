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

        public WorkersController(IWorkersRepository workersRepository)
        {
            _workerRepository = workersRepository;
        }

        [HttpGet("/api/[controller]/{cateringFirmId}")]
        public async Task<IEnumerable<Worker>> GetWorkersAsync(long cateringFirmId)
        {
            return await _workerRepository.GetWorkers(cateringFirmId);
        }
    }

}