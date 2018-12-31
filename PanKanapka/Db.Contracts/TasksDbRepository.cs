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

        public async System.Threading.Tasks.Task CreateTask(TaskCreationItem newTaskItem)
        {
            string insertTaskSqlQuery = @"insert into Tasks values(@ClientFirmId, 0, @Date, @WorkerId)";

            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

                dbConn.Execute(
                        insertTaskSqlQuery,
                        newTaskItem.ClientFirmIds
                            .Select(fId =>
                            {
                                return new
                                {
                                    ClientFirmId = fId,
                                    newTaskItem.Date,
                                    newTaskItem.WorkerId
                                };
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
                @"
                with dates as (
                select top (@dateRangeLength) 
                n = ROW_NUMBER() OVER (ORDER BY [object_id])
                from sys.all_objects
                )

                select cros.dates as TaskDate, 
                    cros.id as WorkerId, 
                    cros.name as WorkerName, 
                    cros.surname as WorkerSurname, 
                    t.isDone as IsDone, 
                    t.ID as TaskId,
                    t.clientFirmID as ClientFirmID,
                    cf.logoUrl as LogoUrl, 
                    cf.name as ClientFirmName, 
                    cf.address as Address
                from Tasks t
                right JOIN
                (
                    select *
                    from (select DATEADD(DAY, n-1, @from) as dates from dates) as d
                    cross join Workers as w
                    where w.ID in @WorkerIds
                ) as cros
                on t.taskDate = cros.dates and t.workerId = cros.id
                left join ClientFirms cf on cf.ID = t.clientFirmID 
                ";

            using (dbConn)
            {
                dbConn.Open();
                if (dbConn.State != ConnectionState.Open)
                {
                    throw new Exception("Nie udalo sie polaczyc z baza");
                }

                DateTime from = tasksFilter.Date.Subtract(TimeSpan.FromDays(tasksFilter.DaysBefore));
                int dateRangeLength = tasksFilter.DaysBefore + tasksFilter.DaysAfter;

                IEnumerable<TaskDbResult> tasks =
                    dbConn.Query<TaskDbResult>(getTaskSqlQuery,
                    new { dateRangeLength, from = from.Date, tasksFilter.WorkerIds });

                List<WorkerTask> workerTasks = tasks.GroupBy(
                dbTask => new Worker()
                {
                    Id = dbTask.WorkerId.Value,
                    Name = dbTask.WorkerName,
                    Surname = dbTask.WorkerSurname
                },
                (worker, groupedTasksByWorkerId) =>
                    new WorkerTask()
                    {
                        Worker = worker,
                        TaskItems = groupedTasksByWorkerId
                        .GroupBy(
                            dbTask => dbTask.TaskDate,
                            (date, groupedTasks) =>
                                new TaskItem()
                                {
                                    Date = date.Value,
                                    Firms = groupedTasks
                                            .Where(dbTask3 => dbTask3.TaskId != null)
                                            .Select(dbTask3 =>
                                            {
                                                return new FirmTask()
                                                {
                                                    TaskId = dbTask3.TaskId.Value,
                                                    Id = dbTask3.ClientFirmID.Value,
                                                    Address = dbTask3.Address,
                                                    IsActiveTask = !dbTask3.IsDone.Value,
                                                    LogoUrl = dbTask3.LogoUrl,
                                                    Name = dbTask3.ClientFirmName
                                                };
                                            })
                                })
                    }
                ).ToList();

                return workerTasks;
            }
        }
    }
}
