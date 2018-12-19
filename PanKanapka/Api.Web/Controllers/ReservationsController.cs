using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    [ApiController]
    public class ReservationsController : Controller
    {
        private IReservationsRepository _reservationsRepository;
        public ReservationsController(IReservationsRepository reservationsRepository)
        {
            _reservationsRepository = reservationsRepository;
        }

        [HttpDelete("api/[controller]/delete")]
        public void DeleteReservations(IEnumerable<long> reservations)
        {
            _reservationsRepository.DeleteReservations(reservations);
        }

        [HttpPost("/api/[controller]")]
        public async Task<IEnumerable<Reservation>> GetReservationsAsync(ReservationFilter reservationsFilter)
        {
            return await _reservationsRepository.GetReservations(reservationsFilter);
        }

    }
}