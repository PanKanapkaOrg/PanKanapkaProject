using Api.Domain.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Api.Domain.Components
{
    public interface ILoginRepository
    {
        Task<Login> GetLoginData(string mail, string password);
    }
}
