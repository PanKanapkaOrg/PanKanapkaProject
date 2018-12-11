
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

        [HttpGet("/api/[controller]")]
        public async Task<Login> GetLoginData([FromQuery]string mail, [FromQuery]string password, [FromQuery] string from)
        {
            Login loginData = await _loginRepository.GetLoginData(mail, password);
            if (from == "web" && loginData.Role!="Manager")
            {
                throw new UnauthorizedAccessException("Logowanie tylko dla managerow");
            }
            
            if (loginData == null)
                throw new UnauthorizedAccessException("Błędny login lub hasło.");
            return loginData;
        }
    }
}