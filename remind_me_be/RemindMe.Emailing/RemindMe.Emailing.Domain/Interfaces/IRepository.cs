using RemindMe.Emailing.Domain.Models;

namespace RemindMe.Emailing.Domain.Interfaces
{
    public interface IRepository
    {
        public Task<BaseResult> StoreEmailSentToUserActivity(string userId, DateTime date);
    }
}
