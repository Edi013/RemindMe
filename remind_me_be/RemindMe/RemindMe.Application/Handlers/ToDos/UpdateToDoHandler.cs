using MediatR;
using Microsoft.Extensions.Configuration;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using System.Configuration;
using System.Globalization;
using System.Runtime.Serialization;

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
            ToDo newToDo = await buildNewToDoAsync(request);
            return await repository.Update(newToDo); ;
        }

        private async Task<ToDo> buildNewToDoAsync(UpdateToDoRequest request)
        {
            string dateTimeFormat = configuration.GetValue<string>("DateTimeFormat");
            var toUpdateToDo = await repository.SingleOrDefaultAsync(request.Id);

            return new ToDo()
            {
                Id = toUpdateToDo.Id,
                CreationDate = toUpdateToDo.CreationDate,
                OwnerId = toUpdateToDo.OwnerId,

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
