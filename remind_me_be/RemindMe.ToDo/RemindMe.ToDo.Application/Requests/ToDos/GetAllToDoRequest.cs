using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.Application.Requests.ToDos
{
    public class GetAllToDoRequest : IRequest<IEnumerable<ToDo>>
    {
    }
}
