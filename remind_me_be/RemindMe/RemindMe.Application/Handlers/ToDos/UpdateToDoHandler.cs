using MediatR;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using System.Configuration;
using System.Globalization;

namespace RemindMe.Application.Handlers.ToDos
{
    public class UpdateToDoHandler : IRequestHandler<UpdateToDoRequest, ToDo>
    {
        private IToDoRepository repository;
        private readonly IConfiguration configuration;


        public UpdateToDoHandler(IToDoRepository _repository, IConfiguration _configuration)
        {
            repository = _repository;
            configuration = _configuration;
        }

        public async Task<ToDo> Handle(UpdateToDoRequest request, CancellationToken cancellationToken)
        {
            //var toUpdateToDo = await repository.GetById(request.Id);
            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");

            var newToDo = new ToDo()
            {
                Id = request.Id,
                Title = request.Title,
                Description = request.Description,
                CreationDate = DateTime.ParseExact(request.CreationDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                StartDate = DateTime.ParseExact(request.StartDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                EndDate = DateTime.ParseExact(request.EndDate, dateTimeFormat, null, DateTimeStyles.AssumeUniversal).ToUniversalTime(),
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,
                OwnerId = request.OwnerId,
            };
           
            return await repository.Update(newToDo); ;
        }


    }
}
