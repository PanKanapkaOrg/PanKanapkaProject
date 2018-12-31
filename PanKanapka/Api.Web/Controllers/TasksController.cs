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
        private INotificationManager _notificationManager;

        public TasksController(ITasksRepository tasksRepository, INotificationManager notificationManager)
        {
            _tasksRepository = tasksRepository;
            _notificationManager = notificationManager;
        }

        [HttpPost("api/[controller]/create")]
        public async Task<IActionResult> CreateTask([FromBody] TaskCreationItem newTaskItem)
        {
            await _tasksRepository.CreateTask(newTaskItem);

            if(newTaskItem.ShouldNotifyWorker)
            {
                await _notificationManager.NotifyWorker(newTaskItem);
            }

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