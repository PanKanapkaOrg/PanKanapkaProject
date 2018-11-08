using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;
using Db.Contracts.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Db.Contracts
{
    public class ReservationsDbRepository : IReservationsRepository
    {
        private IDbConnection dbConn;


        public ReservationsDbRepository(IDbConnection dbConnection)
        {
            dbConn = dbConnection;
        }

        public async Task DeleteReservations(IEnumerable<long> reservationIds)
        {
            string deleteReservationsQuery = @"Delete from Reservation where ID in @reservationIds";
            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

                var affectedRows = dbConn.Query(deleteReservationsQuery, new { reservationIds });
            }
        }

        public async Task<IEnumerable<Reservation>> GetReservations(ReservationFilter reservationsFilter)
        {
            string getReservationsQuery =
                @"select 
                r.ID as ReservationId, 
                c.clientFirmID as ClientFirmId, 
                r.isActive as IsActiveReservation, 
                f.foodname as FoodName, 
                r.quantity as Quantity, 
                f.price*Quantity as PriceTotal, 
                f.imageURL as ItemImageUrl 

                from Reservation r 
                join Foods f on r.foodID = f.ID 
                join Clients c on c.ID =r.clientID 
                where f.cateringFirmID = @CateringFirmId and c.clientFirmID in @ClientFirmIds and reservationDate=@Date";
            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalos sie polaczyc z baza");
                }

                IEnumerable<ReservationDbResult> reservationsDb = dbConn.Query<ReservationDbResult>(getReservationsQuery, reservationsFilter);
                IEnumerable<Reservation> reservations =
                    reservationsDb.GroupBy(
                        dbReservation => dbReservation.ReservationId,
                        (reservationid, groupedReservationsByReservationId) =>
                                new Reservation
                                {
                                    ReservationId = reservationid,
                                    ClientFirmId = groupedReservationsByReservationId.First().ClientFirmId,
                                    IsActiveReservation = groupedReservationsByReservationId.First().IsActiveReservation,
                                    ReservationItems = groupedReservationsByReservationId.
                                        Select(reservationItemResult => new ReservationItem
                                        {
                                            ItemImageUrl = reservationItemResult.ItemImageUrl,
                                            Name = reservationItemResult.FoodName,
                                            PriceTotal = reservationItemResult.PriceTotal
                                        })
                                }
                );
                return reservations;
            }
        }
    }
}
