using Microsoft.AspNetCore.Mvc;
using RemindMe.Emailing.Business;
using RemindMe.Emailing.Domain.Models;

namespace RemindMe.Emailing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class EmailingController : ControllerBase
    {
        private readonly EmailingHandler _emailingHandler;

        public EmailingController(EmailingHandler EmailingHandler)
        {
            _emailingHandler = EmailingHandler;
        }

        [HttpGet("TestEmail")]
        public BaseResult TestEmail()
        {
            return _emailingHandler.TestEmail();
        }

        [HttpPost("SendEmail")]
        public async Task<BaseResult> SendEmailAsync(SendEmailRequest request)
        {
            return await _emailingHandler.SendEmailAsync(request);
        }
    }
}
