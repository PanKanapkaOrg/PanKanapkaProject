using Api.Domain.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Api.Domain.Components
{
    public interface IReservationsRepository
    {
        IEnumerable<Reservation> GetReservations(TasksFilter reservationsFilter);

        void DeleteReservations(IEnumerable<string> reservations);
    }
}
