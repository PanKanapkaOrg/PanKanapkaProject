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
        public async Task<Login> GetLoginData(string mail, string password)
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
                    new { mail, password },
                    splitOn: "FirmId, FirmName",
                    commandType: CommandType.StoredProcedure);
                return loginData.FirstOrDefault();
            }
        }
    }
}