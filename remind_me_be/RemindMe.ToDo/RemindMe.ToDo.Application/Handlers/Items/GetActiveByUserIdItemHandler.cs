using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetActiveByUserIdItemHandler : IRequestHandler<GetActiveItemRequest, IEnumerable<Item>>
    {
        private IItemRepository repository;

        public GetActiveByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public  Task<IEnumerable<Item>> Handle(GetActiveItemRequest request, CancellationToken cancellationToken)
        {
            var result = repository.GetActiveItemsByUserId(request.UserId);
            return result;
        }
    }
}
