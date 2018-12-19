using System.Collections.Generic;
using Api.Domain.Models;

namespace Api.Domain.Components
{
    public interface IClientFirmsRepository
    {
        System.Threading.Tasks.Task<IEnumerable<ClientFirm>> GetClientFirms(long cateringFirmId);

    }
}