using MediatR;
using Microsoft.Extensions.Logging;
using RemindMe.Domain.Results;
using System.ComponentModel.DataAnnotations;

namespace RemindMe.Application.Requests.Logging
{
    public class LoggingRequest : IRequest<BaseResponse>
    {
        [Required(ErrorMessage = "Message is required")]
        public string Message { get; set; }

        public LogLevel Level { get; set; }

        public string Exception { get; set; }
    }
}