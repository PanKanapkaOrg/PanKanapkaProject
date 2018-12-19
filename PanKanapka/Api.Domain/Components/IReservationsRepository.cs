using Api.Domain.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Api.Domain.Components
{
    public interface IReservationsRepository
    {
        Task<IEnumerable<Reservation>> GetReservations(ReservationFilter reservationsFilter);

        System.Threading.Tasks.Task DeleteReservations(IEnumerable<long> reservationIds);
    }
}
