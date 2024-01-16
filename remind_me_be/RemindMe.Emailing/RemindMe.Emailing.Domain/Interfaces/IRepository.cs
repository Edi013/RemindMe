namespace RemindMe.Emailing.Domain.Interfaces
{
    public interface IRepository
    {
        public Task StoreEmailSentToUserActivity(string userId, DateTime date);
    }
}
