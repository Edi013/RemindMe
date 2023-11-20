using MediatR;
using RemindMe.Domain.Entities;

namespace RemindMe.Application.Requests.ToDos
{
    public class CreateToDoRequest : IRequest<ToDo>
    {
        public ToDo entity;

        public CreateToDoRequest(ToDo _entity)
        {
            this.entity = _entity ?? throw new ArgumentNullException(nameof(_entity));
        }
    }
}
