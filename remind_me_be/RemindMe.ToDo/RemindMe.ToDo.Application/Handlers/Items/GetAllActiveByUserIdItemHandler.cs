using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetAllActiveByUserIdItemHandler : IRequestHandler<GetAllActiveItemRequest, IQueryable<Item>>
    {
        private IItemRepository repository;

        public GetAllActiveByUserIdItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public  Task<IQueryable<Item>> Handle(GetAllActiveItemRequest request, CancellationToken cancellationToken)
        {
            var result = repository.GetAllActiveItemsByUserId(request.UserId);
            return result;
        }
    }
}
