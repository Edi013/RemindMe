using MediatR;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

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
        public async Task<String> Test()
        {
            return "Succesful";
        }
    }
}
