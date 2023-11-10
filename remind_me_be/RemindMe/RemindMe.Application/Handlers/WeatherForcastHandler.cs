using MediatR;
using Microsoft.AspNetCore.Mvc;
using RemindMe.Application.Requests;
using RemindMe.Domain.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RemindMe.Application.Handlers
{
    public class WeatherForcastHandler : IRequestHandler<WeatherForecastRequest, WeatherForecastResult>
    {


        [HttpGet("test")]
        public Task<WeatherForecastResult> Handle(WeatherForecastRequest request, CancellationToken cancellationToken)
        {
            

            return waitSeconds();
        }
        private async Task<WeatherForecastResult> waitSeconds()
        {
            await Task.Delay(1000);

            return new WeatherForecastResult()
            {
                Date = DateTime.Now,
                TemperatureC = 32,
            }; 

        }
    }
}
