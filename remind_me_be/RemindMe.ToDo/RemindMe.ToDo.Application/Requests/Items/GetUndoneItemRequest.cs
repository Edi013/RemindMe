using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.ToDo.Application.Requests.Items
{
    public class GetUndoneItemRequest : IRequest<IQueryable<Item>>
    {
        public string UserId;
    }
}
