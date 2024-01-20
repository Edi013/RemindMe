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

        public async Task<IEnumerable<ToDo>> Handle(GetAllToDoRequest request, CancellationToken cancellationToken)
        {
            var result = await repository.GetAll();
            return result;
        }
    }
}
