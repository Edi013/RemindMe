using Azure.Core;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Handlers;
using RemindMe.Application.Requests;
using RemindMe.Domain.Results;

namespace RemindMe.Controller
{

    [ApiController]
    [Route("api/[controller]")]
    public class WeatherForecastController
    {
        private readonly IMediator mediator;
        private readonly IConfiguration configuration;

        public WeatherForecastController(IMediator mediator, IConfiguration configuration)
        {
            this.mediator = mediator;
            this.configuration = configuration;
        }

        [HttpGet("test")]
        public async Task<WeatherForecastResult> Test()
        {
            var req = new WeatherForecastRequest();

            return await mediator.Send(req, CancellationToken.None);
        }
    }
}
