using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;


namespace Db.Contracts
{
    public class LoginDbRepository : ILoginRepository
    {
        private IDbConnection DbConn;
        public LoginDbRepository(IDbConnection dbConnection)
        {
            DbConn = dbConnection;
        }
        public async Task<Login> GetLoginData(string mail, string password, string FCMToken = null)
        {
            string getLoginDataProcedure = @"LoginProcedure";
            using (DbConn)
            {
                DbConn.Open();
                if (DbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udało się polączyć z bazą");
                }
                var loginData = DbConn.Query<Login, Firm, Login>(getLoginDataProcedure,
                    (login, firm) =>
                    {
                        login.Firm = firm;
                        return login;
                    },
                    new { mail, password, FCMToken },
                    splitOn: "FirmId, FirmName",
                    commandType: CommandType.StoredProcedure);
                return loginData.FirstOrDefault();
            }
        }

        public string GetWorkerFcmToken(long workerId)
        {
            using(DbConn)
            {
                DbConn.Open();
                if (DbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udało się polączyć z bazą");
                }

                string query = @"
                        select w.ID, a.FCMToken 
                        from [Workers] as w
                        join [Authentication] a on a.ID = w.AuthID
                        where w.ID = @workerId
                ";

                var items = DbConn.Query(query, new { workerId })
                        .ToDictionary(dapperRow => (long)dapperRow.ID, dapperRow => (string)dapperRow.FCMToken);

                if(items == null || !items.Any())
                {
                    throw new InvalidOperationException($"Nie ma tokenu dla pracownika z id = {workerId}");
                }

                return items[workerId];
            }
        }
    }
}