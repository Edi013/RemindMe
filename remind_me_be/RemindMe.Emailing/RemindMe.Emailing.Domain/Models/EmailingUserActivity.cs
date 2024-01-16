namespace RemindMe.Emailing.Domain.Models
{
    public class EmailingUserActivity
    {
        public int Id { get; set; }
        public Guid UserId { get; set; }
        public DateTime[] Dates { get; set; }
        public int EmailsSent {  get; set; }
    }
}
