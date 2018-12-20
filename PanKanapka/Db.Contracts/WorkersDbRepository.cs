using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;
using Db.Contracts.Models;

namespace Db.Contracts
{
    public class WorkersDbRepository : IWorkersRepository
    {
        IDbConnection dbConn;

        public WorkersDbRepository(IDbConnection dbConnection)
        {
            dbConn = dbConnection;
        }

        public async Task AddWorker (string name, string surname, long cateringFirmId, string email, string password) {
            string addWorkerProcedure = @"AddWorkerProcedure";
            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udało się polączyć z bazą");
                }
                var loginData = dbConn.Execute(addWorkerProcedure, new {name,surname,cateringFirmId,email,password});
            }

        }

        public async Task<IEnumerable<Worker>> GetWorkers(long CateringFirmId)
        {
            string getWorkersQuery =
                @"select ID as Id, name as Name, surname as Surname from Workers 
                where CateringFirmId = @CateringFirmId";

            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new System.Exception("Nie udało sie polaczyc z baza");
                }

                IEnumerable<Worker> workers = dbConn.Query<Worker>(getWorkersQuery, new { CateringFirmId });
                return workers;
            }
        }
    }
}
