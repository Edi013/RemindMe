using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MimeKit;
using RemindMe.Authentication.Domain.DTOs;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models.EmailingSystem;
using RemindMe.Authentication.Domain.Responses;
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

        [HttpPost("Register")]
        public async Task<BaseResponse> Register([FromBody] RegisterDto registerDto)
        {
            var result = 
                await _authenticationHandler.Register(registerDto);

            return result;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login ([FromBody] LoginDto loginDto)
        {
            var result = 
                await _authenticationHandler.Login(loginDto, HttpContext);
            
            return Ok(result);
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

        [Authorize]
        [HttpGet("Test")]
        public string Test()
        {
            return "Test message!\nIf you see this message, the Get http call on https://localhost:7092/Authentication/Test works";
        }
    }
}
