using Api.Domain.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Api.Domain.Components
{
    public interface IWorkerTasksRepository
    {
        Task<IEnumerable<Models.WorkerTask>> GetTasks(TasksFilter tasksFilter);
    }

    public interface IManagerTasksRepository
    {
        System.Threading.Tasks.Task CreateTask(TaskCreationItem newTaskItem);

        System.Threading.Tasks.Task DeleteTasks(IEnumerable<long> taskIds);
    }

    public interface ITasksRepository : IWorkerTasksRepository, IManagerTasksRepository
    {
    }
}


