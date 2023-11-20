using MediatR;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers
{
    public class CreateToDoHandler : IRequestHandler<CreateToDoRequest, ToDo?>
    {
        private IToDoRepository repository;

        public CreateToDoHandler(IToDoRepository _repository)
        {
            repository = _repository;
        }

        public async Task<ToDo> Handle(CreateToDoRequest request, CancellationToken cancellationToken)
        {
            var newToDo = new ToDo() { 
                CreationDate = request.CreationDate.HasValue ? (DateTime)request.CreationDate : DateTime.Now,
                Description = request.Description,
                Difficulty = request.Difficulty,
                EndDate = request.EndDate,
                IsFinished = request.IsFinished,
                OwnerId = request.OwnerId,
                StartDate = request.StartDate,
                Title = request.Title
            };

            ToDo operationResult = await repository.Add(newToDo);
            return operationResult;
        }
    }
}
