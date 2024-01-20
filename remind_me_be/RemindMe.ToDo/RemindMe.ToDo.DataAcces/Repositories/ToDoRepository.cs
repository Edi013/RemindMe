using Microsoft.EntityFrameworkCore;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.DataAcces.Repositories
{
    public class ToDoRepository : RepositoryBase<ToDo>, IToDoRepository
    {
        public ToDoRepository(ApplicationDbContext context)
            : base(context)
        { }
        public async Task<ToDo> SingleOrDefaultAsync(int id)
        {
            return await context.Set<ToDo>()
                .AsNoTracking()
                .SingleAsync(x => x.Id == id);
        }
    }
}
