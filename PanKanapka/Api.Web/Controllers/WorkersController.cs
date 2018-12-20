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

        [HttpPost("api/[controller]/create")]
        public IActionResult AddWorker(string name, string surname, long cateringFirmId, string email, string password)
        {
            _workerRepository.AddWorker(name,surname,cateringFirmId,email,password);
            return Ok();
        }

        [HttpGet("/api/[controller]/{cateringFirmId}")]
        public async Task<IEnumerable<Worker>> GetWorkersAsync(long cateringFirmId)
        {
            return await _workerRepository.GetWorkers(cateringFirmId);
        }
    }

}