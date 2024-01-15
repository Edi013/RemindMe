using RemindMe.Authentication.Domain.Models.EmailingSystem;

namespace RemindMe.Authentication.Domain.Interfaces.EmailingSystem
{
    public interface IEmailService
    {
        void SendEmail(Message message);
    }
}
