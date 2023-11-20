using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.DataAcces.Repositories
{
    public class ToDoRepository : RepositoryBase<ToDo>, IToDoRepository
    {
        public ToDoRepository(ApplicationDbContext context)
            : base (context)
        {
        }
    }
}
