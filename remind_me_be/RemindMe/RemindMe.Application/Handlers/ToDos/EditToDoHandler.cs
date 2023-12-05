using MediatR;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using System.Configuration;

namespace RemindMe.Application.Handlers.ToDos
{
    public class EditToDoHandler : IRequestHandler<EditToDoRequest, ToDo>
    {
        private IToDoRepository repository;
        private readonly IConfiguration configuration;


        public EditToDoHandler(IToDoRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<ToDo> Handle(EditToDoRequest request, CancellationToken cancellationToken)
        {
            var toUpdateToDo = await repository.GetById(request.Id);
            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");

            var newToDo = new ToDo()
            {
                Id = toUpdateToDo.Id,
                OwnerId = toUpdateToDo.OwnerId,
                CreationDate = toUpdateToDo.CreationDate,
                
                Title = request.Title,
                Description = request.Description,
                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null),
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null),
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,
            };
           
            await repository.Update(newToDo);

            return await repository.GetById(request.Id);
        }


    }
}
