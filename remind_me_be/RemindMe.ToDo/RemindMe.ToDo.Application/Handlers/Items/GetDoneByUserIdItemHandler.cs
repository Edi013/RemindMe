using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetDoneByUserIdItemHandler : IRequestHandler<GetDoneItemRequest, IQueryable<Item>>
    {
        private IItemRepository repository;

        public GetDoneByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public Task<IQueryable<Item>> Handle(GetDoneItemRequest request, CancellationToken cancellationToken)
        {
            var result = repository.GetUndoneItemsByUserId(request.UserId);
            return result;
        }
    }
}
