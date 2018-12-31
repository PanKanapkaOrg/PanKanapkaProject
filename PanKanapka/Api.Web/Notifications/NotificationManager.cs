using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Api.Domain.Components;
using Api.Domain.Models;
using Newtonsoft.Json;

public class NotificationManager : INotificationManager
{
    private ILoginRepository _loginRepository;

    private string FireBasePushNotificationsURL = "https://fcm.googleapis.com/fcm/send";

    private string ServerKey = "PUT FCM SERVER KEY HERE";
    
    public NotificationManager(ILoginRepository loginRepository)
    {
        _loginRepository = loginRepository;
    }

    public async Task NotifyWorker(TaskCreationItem newTaskItem)
    {
        string workersFcmToken = _loginRepository.GetWorkerFcmToken(newTaskItem.WorkerId);

        var messageInformation = new Message()
        {
            notification = new Message.Notification()
            {
                title = "Nowe zadania dla Ciebie",
                text = $"Twoj manazer stworzyl dla Ciebie {newTaskItem.ClientFirmIds.Count()} nowych zadan",
            },

            data = null,
            registration_ids = new string[] { workersFcmToken }
        };

        await SendNotification(messageInformation);
    }

    private async Task SendNotification(Message notificationMessage)
    {
        string jsonMessage = JsonConvert.SerializeObject(notificationMessage);

        var request = new HttpRequestMessage(HttpMethod.Post, FireBasePushNotificationsURL);

        request.Headers.TryAddWithoutValidation("Authorization", "key =" + ServerKey);

        request.Content = new StringContent(jsonMessage, Encoding.UTF8, "application/json");

        HttpResponseMessage result;

        using (var client = new HttpClient())
        {
            result = await client.SendAsync(request);
        }

        result.EnsureSuccessStatusCode();
    }


    public class Message
    {
        public string[] registration_ids { get; set; }
        public Notification notification { get; set; }
        public object data { get; set; }

        public class Notification
        {
            public string title { get; set; }
            public string text { get; set; }
        }
    }
}