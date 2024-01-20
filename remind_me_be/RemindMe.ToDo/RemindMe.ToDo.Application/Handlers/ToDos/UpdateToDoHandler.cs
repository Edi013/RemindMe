using MediatR;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using System.Configuration;
using System.Globalization;
using System.Runtime.Serialization;

namespace RemindMe.Application.Handlers.Todos
{
    public class UpdateTodoHandler : IRequestHandler<UpdateTodoRequest, Item>
    {
        private ITodoRepository repository;
        private readonly IConfiguration configuration;


        public UpdateTodoHandler(ITodoRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<Item> Handle(UpdateTodoRequest request, CancellationToken cancellationToken)
        {
            Item newTodo = await buildNewTodoAsync(request);
            return await repository.Update(newTodo); ;
        }

        private async Task<Item> buildNewTodoAsync(UpdateTodoRequest request)
        {
            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");
            var toUpdateTodo = await repository.SingleOrDefaultAsync(request.Id);

            return new Item()
            {
                Id = toUpdateTodo.Id,
                CreationDate = toUpdateTodo.CreationDate,
                OwnerId = toUpdateTodo.OwnerId,

                Title = request.Title,
                Description = request.Description,


                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,

            };
        }
    }
}
