using MimeKit;

namespace RemindMe.Emailing.Domain.Models
{
    public class Message
    {
        public List<MailboxAddress> Receivers { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }

        public Message(string subject, string content, IEnumerable<string> receivers)
        {
            Receivers = new List<MailboxAddress>();
            Receivers.AddRange(
                receivers.Select(x => new MailboxAddress("", x)
            ));
            Subject = subject;
            Content = content;
        }
    }
}
