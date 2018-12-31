using System.Collections.Generic;
using System.Threading.Tasks;
using Api.Domain.Models;

public interface INotificationManager
{
    Task NotifyWorker(TaskCreationItem newTaskItem);
}