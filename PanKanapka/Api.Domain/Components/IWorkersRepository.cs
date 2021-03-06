﻿using System.Collections.Generic;
using Api.Domain.Models;

namespace Api.Domain.Components
{
    public interface IWorkersRepository
    {
        System.Threading.Tasks.Task<IEnumerable<Worker>> GetWorkers(long cateringFirmId);
    }
}
