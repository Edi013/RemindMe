using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.SqlServer.Server;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using System.Globalization;

namespace RemindMe.Application.Handlers.ToDos
{
    public class CreateToDoHandler : IRequestHandler<CreateToDoRequest, ToDo?>
    {
        private IToDoRepository repository;
        private readonly IConfiguration configuration;

        public CreateToDoHandler(IToDoRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<ToDo> Handle(CreateToDoRequest request, CancellationToken cancellationToken)
        {
            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");
            
            var newToDo = new ToDo()
            {
                Title = request.Title,
                Description = request.Description,
                CreationDate = DateTime.ParseExact(request.CreationDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,
                OwnerId = request.OwnerId,
            };

            ToDo operationResult = await repository.Add(newToDo);
            return operationResult;
        }
    }
}
