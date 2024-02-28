using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;
using RemindMe.ToDo.Application.Requests.Items;

namespace RemindMe.ToDo.Application.Handlers.Items
{
    public class GetAllActiveItemHandler : IRequestHandler<GetAllActiveItemRequest, IEnumerable<Item>>
    {
        private IItemRepository repository;

        public GetAllActiveItemHandler(IItemRepository _repository)
        {
            repository = _repository;
        }

        public Task<IEnumerable<Item>> Handle(GetAllActiveItemRequest request, CancellationToken cancellationToken)
        {
            return (Task<IEnumerable<Item>>)repository.GetAllActiveItems();
        }
    }
}
