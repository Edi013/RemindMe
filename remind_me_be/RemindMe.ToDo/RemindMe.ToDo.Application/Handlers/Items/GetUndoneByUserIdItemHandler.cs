using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetUndoneByUserIdItemHandler : IRequestHandler<GetAllActiveItemRequest, IQueryable<Item>>
    {
        private IItemRepository repository;

        public GetUndoneByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public Task<IQueryable<Item>> Handle(GetAllActiveItemRequest request, CancellationToken cancellationToken)
        {
            var result = repository.GetUndoneItemsByUserId(request.UserId);
            return result;
        }
    }
}
