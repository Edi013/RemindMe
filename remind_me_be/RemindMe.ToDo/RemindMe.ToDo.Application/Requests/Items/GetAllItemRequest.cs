using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.Application.Requests.Todos
{
    public class GetAllItemRequest : IRequest<IEnumerable<Item>>
    {
        public string UserId;
    }
}
