using MediatR;
using Microsoft.AspNetCore.Mvc;
using RemindMe.Application.Requests;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Handlers
{
    public class WeatherForcastHandler : IRequestHandler<WeatherForecastRequest, WeatherForecastResult>
    {
        [HttpGet("test")]
        public Task<WeatherForecastResult> Handle(WeatherForecastRequest request, CancellationToken cancellationToken)
        {
            return buildResult();
        }
        private async Task<WeatherForecastResult> buildResult()
        {
            // network delay
            await Task.Delay(1000);

            return new WeatherForecastResult()
            {
                Date = DateTime.Now,
                TemperatureC = 32,
            }; 
        }
    }
}
