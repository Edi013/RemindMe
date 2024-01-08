using RemindMe.Domain.Entities;

namespace RemindMe.Domain.Interfaces
{
    public interface IToDoRepository : IRepository<ToDo>
    {
        Task<ToDo> SingleOrDefaultAsync(int id);
    }
}
