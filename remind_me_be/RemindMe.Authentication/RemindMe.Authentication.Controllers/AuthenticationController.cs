using Microsoft.AspNetCore.Mvc;
using MimeKit;
using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models;
using RemindMe.Authentication.Domain.Models.EmailingSystem;
using RemindMe.Authentication.Handlers;

namespace RemindMe.Authentication.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthenticationController : ControllerBase
    {
        private readonly AuthenticationHandler _authenticationHandler;
        private readonly IEmailService _emailService;

        public AuthenticationController(AuthenticationHandler authenticationHandler, IEmailService emailService)
        {
            _authenticationHandler = authenticationHandler;
            _emailService = emailService;
        }

        [HttpPut("Register")]
        public async Task<BaseResult> Register(RegisterDto registerDto)
        {
            var result = await _authenticationHandler.Register(registerDto);

            return result;
        }

        [HttpPost("Login")]
        public async Task<BaseResult> Login (LoginDto loginDto)
        {
            var result = await _authenticationHandler.Login(loginDto);

            return result;
        }

        [HttpPut("SeedRoles")]
        public Task<BaseResult> SeedRoles()
        {
            var result = _authenticationHandler.SeedRoles();

            return result;
        }

        [HttpGet("TestEmail")]
        public async Task<BaseResult> TestEmail()
        {
            var receivers = new string[]{
                "edymare97@yahoo.com"
            };
            var message = new Message("Test email", "Email for test.", receivers);

            _emailService.SendEmail(message);

            return new BaseResult()
            {
                HttpStatusCode = System.Net.HttpStatusCode.OK,
                Message = "Email was sent successfully"
            };
        }
    }
}
