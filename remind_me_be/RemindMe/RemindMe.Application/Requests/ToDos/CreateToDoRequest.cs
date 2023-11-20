using MediatR;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Results.ToDos;

namespace RemindMe.Application.Requests.ToDos
{
    public class CreateToDoRequest : IRequest<CreateToDoResult>
    {
        public ToDo entity;

        public CreateToDoRequest(ToDo _entity)
        {
            this.entity = _entity ?? throw new ArgumentNullException(nameof(_entity));
        }
    }
}
