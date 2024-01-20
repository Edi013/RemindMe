using MediatR;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers.Todos
{
    public class GetAllTodoHandler : IRequestHandler<GetAllTodoRequest, IEnumerable<Item>>
    {
        private ITodoRepository repository;

        public GetAllTodoHandler(ITodoRepository _repository)
        {
            repository = _repository;
        }

        public async Task<IEnumerable<Item>> Handle(GetAllTodoRequest request, CancellationToken cancellationToken)
        {
            var result = await repository.GetAll();
            return result;
        }
    }
}
