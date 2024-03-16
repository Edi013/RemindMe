using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.ToDo.Application.Requests.Items
{
    public class GetDoneItemRequest : IRequest<IQueryable<Item>>
    {
        public string UserId;
    }
}
