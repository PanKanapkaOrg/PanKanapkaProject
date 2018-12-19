using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Threading.Tasks;

namespace Db.Contracts
{
    public class ClientFirmsDbRepository:IClientFirmsRepository
    {
        IDbConnection _dbConnection;
        public ClientFirmsDbRepository(IDbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public async Task<IEnumerable<ClientFirm>> GetClientFirms(long cateringFirmId)
        {
            string getClientFirmsQuery = 
                @"select ID as Id, name as Name, address as Address, logoUrl as LogoUrl from ClientFirms cf 
                join CateringFirmClientFirm cfcf on cf.ID=cfcf.ClientFirmID 
                where cfcf.CateringFirmID = @cateringFirmId";
            using (_dbConnection)
            {
                _dbConnection.Open();

                if (_dbConnection.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

                IEnumerable<ClientFirm> clientFirms = _dbConnection.Query<ClientFirm>(getClientFirmsQuery, new { cateringFirmId });
                return clientFirms;
            }

        }
    }
}
