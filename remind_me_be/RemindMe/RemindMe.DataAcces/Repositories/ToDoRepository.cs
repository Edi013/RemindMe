using RemindMe.Domain.Entities;

namespace RemindMe.DataAcces.Repositories
{
    public class ToDoRepository : RepositoryBase<ToDo>
    {
        public ToDoRepository(ApplicationDbContext context)
            : base (context)
        {
        }

    }
}
