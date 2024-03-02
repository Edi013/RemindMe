using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetAllActiveItemHandler : IRequestHandler<GetAllActiveItemRequest, IQueryable<Item>>
    {
        private IItemRepository repository;

        public GetAllActiveItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public  Task<IQueryable<Item>> Handle(GetAllActiveItemRequest request, CancellationToken cancellationToken)
        {
            var a = repository.GetAllActiveItems();
            return a;
        }
    }
}
