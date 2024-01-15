using MailKit.Net.Smtp;
using MimeKit;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models.EmailingSystem;

namespace RemindMe.Authentication.Notifications
{
    public class EmailService : IEmailService
    {
        private readonly EmailConfigurator _emailConfigurator;

        public EmailService(EmailConfigurator emailConfigurator)
        {
            _emailConfigurator = emailConfigurator;
        }

        public void SendEmail(Message message)
        {
            var emailMessage = CreateEmailMessage(message);
            Send(emailMessage);
        }

        private MimeMessage CreateEmailMessage(Message message)
        {
            var emailMessage = new MimeMessage();

            emailMessage.From.Add(new MailboxAddress("", _emailConfigurator.From));

            emailMessage.To.AddRange((IEnumerable<InternetAddress>)message.Receivers);
            emailMessage.Subject = message.Subject;
            emailMessage.Body = new TextPart(MimeKit.Text.TextFormat.Text) {
                Text = message.Content
            };

            return emailMessage;
        }

        private void Send(MimeMessage mailMessage)
        {
            using var client = new SmtpClient();
            try
            {
                client.Connect(_emailConfigurator.SmtpServer, _emailConfigurator.Port, true);
                client.AuthenticationMechanisms.Remove("XOAUTH2");
                client.Authenticate(_emailConfigurator.UserName, _emailConfigurator.Password);

                client.Send(mailMessage);
            }
            catch(Exception err)
            {
                Console.WriteLine(err.StackTrace.ToString());
                throw;
            }
            finally
            {
                client.Disconnect(true);
                client.Dispose();
            }
        }
    }
}
