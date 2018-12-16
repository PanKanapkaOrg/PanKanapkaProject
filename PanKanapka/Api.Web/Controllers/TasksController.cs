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
        private ITasksRepository _tasksRepository;

        public TasksController(ITasksRepository tasksRepository)
        {
            _tasksRepository = tasksRepository;
        }

        [HttpPost("api/[controller]/create")]
        public IActionResult CreateTasks([FromBody] IEnumerable<TaskCreationItem> tasksItems)
        {
            _tasksRepository.CreateTasks(tasksItems);
            return Ok();
        }

        [HttpPost("api/[controller]/delete")]
        public void DeleteTasks([FromBody] IEnumerable<long> taskIds)
        {
            _tasksRepository.DeleteTasks(taskIds);
        }

        [HttpPost("/api/[controller]")]
        public async Task<IEnumerable<WorkerTask>> GetTasksAsync([FromBody] TasksFilter tasksFilter)
        {
            return await _tasksRepository.GetTasks(tasksFilter);
        }
    }
}