using RemindMe.Emailing.Domain.Interfaces;

namespace RemindMe.Emailing.DataAccess
{
    public class EmailingUserActivityRepository : IRepository
    {
        public Task StoreEmailSentToUserActivity(string userId, DateTime date)
        {
            throw new NotImplementedException();
        }
    }
}
