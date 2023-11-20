using MediatR;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Interfaces;
using RemindMe.Domain.Results.ToDos;

namespace RemindMe.Application.Handlers
{
    public class CreateToDoHandler : IRequestHandler<CreateToDoRequest, CreateToDoResult>
    {
        private IToDoRepository repository;

        public CreateToDoHandler(IToDoRepository _repository)
        {
            repository = _repository;
        }

        public async Task<CreateToDoResult> Handle(CreateToDoRequest request, CancellationToken cancellationToken)
        {
            var addedEntity = await repository.Add(request.entity);
            return new CreateToDoResult(addedEntity) ;
        }
    }
}
