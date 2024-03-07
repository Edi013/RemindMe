using RemindMe.Domain.Entities;

namespace RemindMe.Domain.Interfaces
{
    public interface IItemRepository : IRepository<Item>
    {
        Task<Item> SingleOrDefaultAsync(int id);
        Task<IQueryable<Item>> GetAllActiveItemsByUserId(string userId);
        Task<IQueryable<Item>> GetAllByUserId(string userId);

    }
}
