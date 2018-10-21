using Api.Domain.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace Api.Domain.Components
{
    public interface ITasksRepository
    {
        IEnumerable<Task> GetTasks(TasksFilter tasksFilter);

        void CreateTasks(IEnumerable<TaskCreationItem> tasksItems);

        void DeleteTasks(IEnumerable<string> taskIds);

    }
}


