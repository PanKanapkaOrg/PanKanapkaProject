using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Api.Domain.Components;
using Api.Domain.Models;
using Dapper;

namespace Db.Contracts
{
    public class TasksRepository : ITasksRepository
    {
        public void CreateTasks(IEnumerable<TaskCreationItem> tasksItems)
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
        }

        public void DeleteTasks(IEnumerable<string> taskIds)
        {
            throw new System.NotImplementedException();
        }

        public IEnumerable<Task> GetTasks(TasksFilter tasksFilter)
        {
            throw new System.NotImplementedException();
        }
    }
}
