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
    public class TasksDbRepository : ITasksRepository
    {
        IDbConnection dbConn;

        public TasksDbRepository(IDbConnection dbConnection)
        {
            dbConn = dbConnection;
        }

        public async System.Threading.Tasks.Task CreateTasks(IEnumerable<TaskCreationItem> tasksItems)
        {
            string insertTaskSqlQuery = @"insert into Tasks values(@ClientFirmId, 0, @Date, @WorkerId)";

            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

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

        public async System.Threading.Tasks.Task DeleteTasks(IEnumerable<long> taskIds)
        {
            string deleteTaskSqlQuery = @"Delete from Tasks where ID in @ids";

            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }
                var affectedRows = dbConn.Query(deleteTaskSqlQuery, new { ids = taskIds });
            }
        }

        public async Task<IEnumerable<Api.Domain.Models.WorkerTask>> GetTasks(TasksFilter tasksFilter)
        {
            string getTaskSqlQuery = 
                @"select w.ID as WorkerId, w.name as WorkerName, w.surname as WorkerSurname, t.taskDate as TaskDate, cf.logoUrl as LogoUrl, 
                cf.name as ClientFirmName, cf.address as Address, t.isDone as IsDone 
                from Tasks t 
                join Workers w on w.ID = t.workerID 
                join ClientFirms cf on cf.ID = t.clientFirmID 
                where w.ID in @workerIds and t.taskDate between CONVERT(DATETIME, @Date, 102)-@DaysBefore and CONVERT(DATETIME, @Date, 102)+@DaysAfter; ";

            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

                IEnumerable<TaskDbResult> tasks = dbConn.Query<TaskDbResult>(getTaskSqlQuery, tasksFilter);
                IEnumerable<WorkerTask> workerTasks = tasks.GroupBy(
                dbTask => new Worker()
                {
                    Id = dbTask.WorkerId,
                    Name = dbTask.WorkerName,
                    Surname = dbTask.WorkerSurname
                },
                (worker, groupedTasksByWorkerId) =>
                    new WorkerTask()
                    {
                        Worker = worker,

                        TaskItems = groupedTasksByWorkerId.GroupBy(dbTask => dbTask.TaskDate, (date, groupedTasks) =>
                        new TaskItem()
                        {
                            Date = date,
                            Firms = groupedTasks.Select(dbTask3 =>
                                    {
                                        return new FirmTask()
                                        {
                                            Address = dbTask3.Address,
                                            IsActiveTask = !dbTask3.IsDone,
                                            LogoUrl = dbTask3.LogoUrl,
                                            Name = dbTask3.ClientFirmName
                                        };
                                    })
                        })
                    }
                );
                return workerTasks;
            }
        }
    }
}
