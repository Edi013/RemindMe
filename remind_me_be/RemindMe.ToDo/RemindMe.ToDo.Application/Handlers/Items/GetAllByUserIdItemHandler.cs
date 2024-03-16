using MediatR;
using RemindMe.Application.Requests.Todos;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.Application.Handlers.Todos
{
    public class GetAllByUserIdItemHandler : IRequestHandler<GetAllItemRequest, IEnumerable<Item>>
    {
        private IItemRepository repository;

        public GetAllByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public async Task<IEnumerable<Item>> Handle(GetAllItemRequest request, CancellationToken cancellationToken)
        {
            var result = await repository.GetAllByUserId(request.UserId);
            return result;
        }
    }
}
