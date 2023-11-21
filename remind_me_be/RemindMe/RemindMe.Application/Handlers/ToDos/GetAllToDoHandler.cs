using MediatR;
using RemindMe.Application.Requests.ToDos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers.ToDos
{
    public class GetAllToDoHandler : IRequestHandler<GetAllToDoRequest, IEnumerable<ToDo>>
    {
        private IToDoRepository repository;

        public GetAllToDoHandler(IToDoRepository _repository)
        {
            repository = _repository;
        }

        public Task<IEnumerable<ToDo>> Handle(GetAllToDoRequest request, CancellationToken cancellationToken)
        {
            return repository.GetAll();
        }
    }
}
