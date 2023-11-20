using RemindMe.Domain.Entities;

namespace RemindMe.Domain.Results.ToDos
{
    public class CreateToDoResult
    {
        public ToDo entity;

        public CreateToDoResult(ToDo _entity)
        {
            this.entity = _entity ?? throw new ArgumentNullException(nameof(_entity));
        }
    }
}
