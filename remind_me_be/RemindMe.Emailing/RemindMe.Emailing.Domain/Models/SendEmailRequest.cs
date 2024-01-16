namespace RemindMe.Emailing.Domain.Models
{
    public class SendEmailRequest
    {
        public string[] ReceiversId { get; set; }
        public string[] ReceiversEmail { get; set; }
        public string Subject { get; set; }
        public string Content { get; set; }
    }
}
