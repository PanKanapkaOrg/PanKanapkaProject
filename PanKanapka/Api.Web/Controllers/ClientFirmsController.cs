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
        private IClientFirmsRepository _clientFirmsRepository;

        public ClientFirmsController(IClientFirmsRepository clientFirmsRepository)
        {
            _clientFirmsRepository = clientFirmsRepository;
        }

        [HttpGet("/api/[controller]/{cateringFirmId}")]
        public async Task<IEnumerable<ClientFirm>> GetClientFirms(long cateringFirmId)
        {
            return await _clientFirmsRepository.GetClientFirms(cateringFirmId);
        }
    }

    
}