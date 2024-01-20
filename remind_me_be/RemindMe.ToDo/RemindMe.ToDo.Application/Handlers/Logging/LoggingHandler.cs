using MediatR;
using Microsoft.Extensions.Logging;
using RemindMe.Application.Requests.Logging;
using RemindMe.Domain.Results;

namespace RemindMe.Application.Handlers.Logging
{
    public class LoggingHandler : IRequestHandler<LoggingRequest, BaseResult>
    {
        private readonly ILogger<LoggingHandler> logger;

        public LoggingHandler(ILogger<LoggingHandler> logger)
        {
            this.logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }
        public Task<BaseResult> Handle(LoggingRequest request, CancellationToken cancellationToken)
        {
            switch (request.Level)
            {
                case LogLevel.Information:
                    logger.LogInformation(request.Message);
                    break;

                case LogLevel.Warning:
                    logger.LogWarning(request.Message);
                    break;

                case LogLevel.Error:
                    logger.LogError("An error occurred: {0}", request.Message);
                    break;

                default:
                    throw new InvalidCastException();
            }

            return Task.FromResult(
                new BaseResult() 
                {
                    HttpCodeStatus = System.Net.HttpStatusCode.Created,
                    Message = "Message logged."
                });
        }
    }
}