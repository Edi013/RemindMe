using MediatR;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers.ToDos
{
    public class EditToDoHandler : IRequestHandler<EditToDoRequest, ToDo>
    {
        private IToDoRepository repository;

        public EditToDoHandler(IToDoRepository _repository)
        {
            repository = _repository;
        }

        public async Task<ToDo> Handle(EditToDoRequest request, CancellationToken cancellationToken)
        {
            var newToDo = new ToDo()
            {
                Id = request.Id,
                Title = request.Title,
                Description = request.Description,
                StartDate = request.StartDate,
                EndDate = request.EndDate,
                IsFinished = request.IsFinished,
                Difficulty = request.Difficulty,
                OwnerId = request.OwnerId,
                CreationDate = request.CreationDate,
            };

            await repository.Update(newToDo);

            return await repository.GetById(request.Id);
        }


    }
}
