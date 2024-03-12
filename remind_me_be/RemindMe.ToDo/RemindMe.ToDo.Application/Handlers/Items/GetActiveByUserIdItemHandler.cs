using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetActiveByUserIdItemHandler : IRequestHandler<GetAllActiveItemRequest, IQueryable<Item>>
    {
        private IItemRepository repository;

        public GetActiveByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public  Task<IQueryable<Item>> Handle(GetAllActiveItemRequest request, CancellationToken cancellationToken)
        {
            var result = repository.GetActiveItemsByUserId(request.UserId);
            return result;
        }
    }
}
