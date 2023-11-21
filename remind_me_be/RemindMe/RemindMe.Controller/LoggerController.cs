using MediatR;
using Microsoft.AspNetCore.Mvc;
using RemindMe.Application.Requests.Logging;

namespace RemindMe.Controller
{
    [ApiController]
    [Route("Api/[controller]")]
    public class LoggerController : ControllerBase
    {
        private readonly IMediator mediator;

        public LoggerController(IMediator mediator)
        {
            this.mediator = mediator;
        }

        [HttpPost]
        public async Task<IActionResult> Log(LoggingRequest request)
        {
            if (ModelState.IsValid)
            {
                var result = await mediator.Send(request);
                return Ok(result);
            }

            return BadRequest("Logging has failed");
        }
    }
}
