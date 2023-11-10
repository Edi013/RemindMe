using MediatR;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Requests
{
    public class WeatherForecastRequest : IRequest<WeatherForecastResult>
    {
    }
}
