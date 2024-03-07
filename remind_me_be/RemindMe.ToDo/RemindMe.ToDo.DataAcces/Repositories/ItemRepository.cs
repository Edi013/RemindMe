using Microsoft.EntityFrameworkCore;
using RemindMe.Domain.Entities;
using RemindMe.Domain.Interfaces;

namespace RemindMe.DataAcces.Repositories
{
    public class ItemRepository : RepositoryBase<Item>, IItemRepository
    {
        public ItemRepository(ApplicationDbContext context)
            : base(context)
        { }
        public async Task<Item> SingleOrDefaultAsync(int id)
        {
            return await context.Set<Item>()
                .AsNoTracking()
                .SingleAsync(x => x.Id == id);
        }

        public async Task<IQueryable<Item>> GetAllActiveItemsByUserId(string userId)
        {
            DateTime dateTimeNow = DateTime.UtcNow; 

            return context.Set<Item>().Where(currentItem =>
                 (currentItem.OwnerId == userId) && 
                    (currentItem.StartDate.ToUniversalTime() < dateTimeNow) && (dateTimeNow < currentItem.EndDate.ToUniversalTime()));
        }

        public async Task<IQueryable<Item>> GetAllByUserId(string userId)
        {
            return context.Set<Item>().Where(currentItem => (currentItem.OwnerId == userId));
        }

    }
}
