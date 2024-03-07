using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.ToDo.Application.Requests.Items
{
    public class GetAllActiveItemRequest : IRequest<IQueryable<Item>>
    {
        public string UserId;
    }
}
