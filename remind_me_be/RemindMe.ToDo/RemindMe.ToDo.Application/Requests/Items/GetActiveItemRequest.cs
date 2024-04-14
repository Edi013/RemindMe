using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.ToDo.Application.Requests.Items
{
    public class GetActiveItemRequest : IRequest<IEnumerable<Item>>
    {
        public string UserId;
    }
}
