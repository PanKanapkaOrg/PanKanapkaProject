using System.Collections.Generic;
using Api.Domain.Components;
using Api.Domain.Models;
using Db.Contracts;
using Microsoft.AspNetCore.Mvc;

namespace Api.Web.Controllers
{
    [ApiController]
    public class TasksController : Controller
    {
        private List<WorkerTask> tasks = new List<WorkerTask>();

        ITasksRepository repo = new TasksRepository();

        [HttpPost("api/tasks/create")]
        public IActionResult CreateTasks([FromBody] IEnumerable<TaskCreationItem> tasksItems)
        {
            /* foreach(taskItems[n].ClientFirmsIs[n]
             * insert into Tasks values(clinentFirmsIds[n], 0, convertToDate(tasksItems[n].Date), tasksItems[n].WorkerId
             */
            repo.CreateTasks(tasksItems);
            return Ok();
        }

        [HttpDelete("api/tasks/delete")]
        public void DeleteTasks(IEnumerable<string> taskIds)
        {
            //delete from Tasks where ID in (taskIds{})
        }

        [HttpPost("api/tasks")]
        public IEnumerable<WorkerTask> GetTasks([FromBody] TasksFilter tasksFilter)
        {
            /*
             * foreach taskFilter.WorkersIds[n]
             *   select w.name, w.surname, t.taskDate, cf.logoUrl, cf.name, cf.address, t.isDone
  from Tasks t
  join Workers w on w.ID = t.workerID
  join ClientFirms cf on cf.ID = t.clientFirmID
  where w.ID in ('workerIds') and t.taskDate in (datediff(DAY, 1, 'date'), 'date', dateadd(DAY, 1, 'date'))
             */

            return new List<WorkerTask>
            {
                GetTask()
            };
        }

        private WorkerTask GetTask()
        {
            return new WorkerTask()
            {
                Worker = new Worker()
                {
                    Name = "Yevhenii",
                    Surname = "kyshko"
                },
                TaskItems = new List<TaskItem>
                {
                    new TaskItem()
                    {
                        Date = "2009/10/05",
                        Firms = new List<FirmTask>
                        {
                            new FirmTask()
                            {
                                LogoUrl = null,
                                Name = "firm1",
                                Address="addressFirm1",
                                IsActiveTask = true
                            }
                        }
                    }
                }
            };
        }
    }
}