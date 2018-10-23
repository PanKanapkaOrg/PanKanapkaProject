using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    public class ReservationsController : Controller
    {
        public void DeleteReservations(IEnumerable<string> reservations)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Reservation> GetReservations(ReservationFilter reservationsFilter)
        {
            return new List<Reservation>
            {
                new Reservation()
                {
                    ClientFirmId = 13124,
                    ReservationId = 1231,
                    IsActiveReservation = true,
                    ReservationItems = new List<ReservationItem>
                    {
                        new ReservationItem()
                        {
                            Name = "bulka",
                            PriceTotal = 456.34,
                            ItemImageUrl = null,
                            Quantity = 3
                        }
                    }
                }
            };
        }

        public IActionResult Index()
        {
            return View();
        }
    }
}