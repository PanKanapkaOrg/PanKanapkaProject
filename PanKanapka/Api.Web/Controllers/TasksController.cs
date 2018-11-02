using System;
using System.Collections.Generic;
using System.Threading.Tasks;
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

        ITasksRepository _tasksRepository;

        public TasksController(ITasksRepository tasksRepository)
        {
            _tasksRepository = tasksRepository;
        }

        [HttpPost("/create")]
        public IActionResult CreateTasks([FromBody] IEnumerable<TaskCreationItem> tasksItems)
        {
            /* foreach(taskItems[n].ClientFirmsIs[n]
             * insert into Tasks values(clinentFirmsIds[n], 0, convertToDate(tasksItems[n].Date), tasksItems[n].WorkerId
             */
            _tasksRepository.CreateTasks(tasksItems);
            return Ok();
        }

        [HttpDelete("/delete")]
        public void DeleteTasks(IEnumerable<long> taskIds)
        {
            //delete from Tasks where ID in (taskIds{})
            _tasksRepository.DeleteTasks(taskIds);
        }

        [HttpPost("/api/[controller]")]
        public async Task<IEnumerable<WorkerTask>> GetTasksAsync([FromBody] TasksFilter tasksFilter)
        {
            /*
             * foreach taskFilter.WorkersIds[n]
            */
            return await _tasksRepository.GetTasks(tasksFilter);
        }
    }
}