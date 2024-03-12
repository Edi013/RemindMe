using RemindMe.Domain.Entities;

namespace RemindMe.Domain.Interfaces
{
    public interface IItemRepository : IRepository<Item>
    {
        Task<Item> SingleOrDefaultAsync(int id);
        Task<IQueryable<Item>> GetActiveItemsByUserId(string userId);
        Task<IQueryable<Item>> GetAllByUserId(string userId);
        Task<IQueryable<Item>> GetDoneItemsByUserId(string userId);
        Task<IQueryable<Item>> GetUndoneItemsByUserId(string userId);
    }
}
