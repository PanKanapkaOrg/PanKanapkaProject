
using Api.Domain.Components;
using Api.Domain.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Net;
using System.Threading.Tasks;

namespace Api.Web.Controllers
{
    [ApiController]
    public class LoginController : Controller
    {
        private ILoginRepository _loginRepository;
        public LoginController(ILoginRepository loginRepository)
        {
            _loginRepository = loginRepository;
        }

        [HttpPost("/api/[controller]")]
        public async Task<Login> GetLoginData([FromQuery]string mail, [FromQuery]string password, string from)
        {
            if (from == null || from != "web")
            {
                throw new UnauthorizedAccessException("Logowanie tylko dla managerow");
            }
            Login loginData = await _loginRepository.GetLoginData(mail, password);
            if (loginData == null)
                throw new UnauthorizedAccessException("Błędny login lub hasło.");
            return loginData;
        }
    }
}