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
                CreationDate = DateTime.ParseExact(request.CreationDate, dateTimeFormat, null),
                Description = request.Description,
                Difficulty = request.Difficulty,
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null),
                IsFinished = request.IsFinished,
                OwnerId = request.OwnerId,
                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null),
                Title = request.Title,
            };

            ToDo operationResult = await repository.Add(newToDo);
            return operationResult;
        }
    }
}
