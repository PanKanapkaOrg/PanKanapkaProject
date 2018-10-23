using System;
using System.Collections.Generic;
using System.Text;

namespace Db.Contracts.Models
{
    public class TaskDbResult
    {
       /* select w.name, w.surname, t.taskDate, cf.logoUrl, cf.name, cf.address, t.isDone
  from Tasks t
  join Workers w on w.ID = t.workerID
  join ClientFirms cf on cf.ID = t.clientFirmID
  where w.ID in ('workerIds') and t.taskDate in (datediff(DAY, 1, 'date'), 'date', dateadd(DAY, 1, 'date'))
  */
    }
}
