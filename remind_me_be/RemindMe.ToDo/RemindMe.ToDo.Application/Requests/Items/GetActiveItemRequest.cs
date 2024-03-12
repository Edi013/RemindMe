using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.ToDo.Application.Requests.Items
{
    public class GetActiveItemRequest : IRequest<IQueryable<Item>>
    {
        public string UserId;
    }
}
