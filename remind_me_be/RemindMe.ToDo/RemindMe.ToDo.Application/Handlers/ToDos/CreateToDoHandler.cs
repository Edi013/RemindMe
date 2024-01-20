using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.SqlServer.Server;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using System.Globalization;

namespace RemindMe.Application.Handlers.Todos
{
    public class CreateTodoHandler : IRequestHandler<CreateTodoRequest, Item?>
    {
        private ITodoRepository repository;
        private readonly IConfiguration configuration;

        public CreateTodoHandler(ITodoRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<Item> Handle(CreateTodoRequest request, CancellationToken cancellationToken)
        {
            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");
            
            var newTodo = new Item()
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

            Item operationResult = await repository.Add(newTodo);
            return operationResult;
        }
    }
}
