using RemindMe.Domain.Entities;

namespace RemindMe.Domain.Interfaces
{
    public interface IItemRepository : IRepository<Item>
    {
        Task<Item> SingleOrDefaultAsync(int id);
    }
}
