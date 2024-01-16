namespace RemindMe.Emailing.Domain.Models
{
    public class EmailingUserActivity
    {
        public int Id { get; set; }
        public string UserId { get; set; }
        public DateTime[] UtcDates { get; set; }
        public int EmailsSent {  get; set; }
    }
}
