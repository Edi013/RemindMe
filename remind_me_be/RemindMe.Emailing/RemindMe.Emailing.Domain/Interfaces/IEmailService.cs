using RemindMe.Emailing.Domain.Models;

namespace RemindMe.Emailing.Domain.Interfaces
{
    public interface IEmailService
    {
        void SendEmail(Message message);
    }
}
