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
            var addedEntity = await repository.Add(request.entity);
            return addedEntity;
        }
    }
}
