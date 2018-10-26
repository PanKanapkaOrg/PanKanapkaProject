using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    public class ClientFirmsController : Controller
    {
        private readonly IClientFirmsRepository _clientFirmsRepository;

        public ClientFirmsController()
        {
            _clientFirmsRepository = new FakeClientFirmsRepo();
        }

        [HttpGet("/api/{controller}/{cateringFirmId}")]
        public async Task<IEnumerable<ClientFirm>> GetClientFirms(long cateringFirmId)
        {
            return await _clientFirmsRepository.GetClientFirms(cateringFirmId);
        }
    }

    class FakeClientFirmsRepo : IClientFirmsRepository
    {
        public Task<IEnumerable<ClientFirm>> GetClientFirms(long cateringFirmId)
        {
            IEnumerable<ClientFirm> firms = new List<ClientFirm>();

            return Task.FromResult(firms);
        }
    }
}