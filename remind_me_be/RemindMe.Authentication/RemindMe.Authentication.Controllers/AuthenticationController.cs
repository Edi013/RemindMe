using Microsoft.AspNetCore.Mvc;
using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Interfaces;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models.EmailingSystem;
using RemindMe.Authentication.Domain.Responses;

namespace RemindMe.Authentication.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthenticationController : ControllerBase
    {
        private readonly IAuthenticationHandler _authenticationHandler;
        private readonly IEmailService _emailService;

        public AuthenticationController(IAuthenticationHandler authenticationHandler, IEmailService emailService)
        {
            _authenticationHandler = authenticationHandler;
            _emailService = emailService;
        }

        [HttpPost("Register")]
        public async Task<BaseResponse> Register([FromBody] RegisterDto registerDto)
        {
            var result = 
                await _authenticationHandler.Register(registerDto);

            return result;
        }

        [HttpPost("Login")]
        public async Task<LoginResponse> Login ([FromBody] LoginDto loginDto)
        {
            var result = 
                await _authenticationHandler.Login(loginDto);
            
            return result;
        }

        [HttpGet("ConfirmEmail")]
        public async Task<BaseResponse> ConfirmEmail(string userId, string token)
        {

            return await _authenticationHandler.ConfirmEmail(userId, token);
        }

        [HttpPut("SeedRoles")]
        public Task<BaseResponse> SeedRoles()
        {
            var result = _authenticationHandler.SeedRoles();

            return result;
        }

        [HttpGet("TestEmail")]
        public async Task<BaseResponse> TestEmail()
        {
            var receivers = new string[]{
                "edymare97@yahoo.com"
            };
            var message = new Message("Test auth email", "Email for testing authication emailing.", receivers);

            _emailService.SendEmail(message);

            return new BaseResponse()
            {
                HttpStatusCode = System.Net.HttpStatusCode.OK,
                Message = "Email was sent successfully"
            };
        }

        [HttpGet("Test")]
        public string Test()
        {
            return "Test message!\nIf you see this message, the Get http call on https://localhost:7092/Authentication/Test works";
        }
    }
}
