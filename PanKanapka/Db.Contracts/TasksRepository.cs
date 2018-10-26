using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;

namespace Db.Contracts
{
    public class TasksRepository : ITasksRepository
    {
        public System.Threading.Tasks.Task CreateTasks(IEnumerable<TaskCreationItem> tasksItems)
        {
            string insertTaskSqlQuery = "insert into Tasks values(@ClientFirmId, 0, @Date, @WorkerId)";

            //Change DataSource to ./SQLEXPRESS
            using (IDbConnection dbConn = new SqlConnection(@"Integrated Security = SSPI; Persist Security Info = False; Initial Catalog = Projekt; Data Source =.;"))
            {
                dbConn.Open();
                if (dbConn.State == ConnectionState.Open)
                {
                    var affectedRows = dbConn.Execute(insertTaskSqlQuery,
                    tasksItems
                    .SelectMany(p =>
                    {
                        return p.ClientFirmIds
                             .Select(fId =>
                             {
                                 return new
                                 {
                                     ClientFirmId = fId,
                                     p.Date,
                                     p.WorkerId
                                 };
                             });
                    })
                    );
                }
            }

            return System.Threading.Tasks.Task.CompletedTask;
        }

        public System.Threading.Tasks.Task DeleteTasks(IEnumerable<string> taskIds)
        {
            throw new System.NotImplementedException();
        }

        public Task<IEnumerable<Api.Domain.Models.Task>> GetTasks(TasksFilter tasksFilter)
        {
            throw new System.NotImplementedException();
        }
    }
}
