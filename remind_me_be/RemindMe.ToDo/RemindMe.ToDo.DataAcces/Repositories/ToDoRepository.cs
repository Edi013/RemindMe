using Microsoft.EntityFrameworkCore;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.DataAcces.Repositories
{
    public class TodoRepository : RepositoryBase<Item>, ITodoRepository
    {
        public TodoRepository(ApplicationDbContext context)
            : base(context)
        { }
        public async Task<Item> SingleOrDefaultAsync(int id)
        {
            return await context.Set<Item>()
                .AsNoTracking()
                .SingleAsync(x => x.Id == id);
        }
    }
}
