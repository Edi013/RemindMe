using RemindMe.Domain.Entities;

namespace RemindMe.Domain.Interfaces
{
    public interface ITodoRepository : IRepository<Item>
    {
        Task<Item> SingleOrDefaultAsync(int id);
    }
}
