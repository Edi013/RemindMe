namespace RemindMe.Authentication.Domain.Models.EmailingSystem
{
    public class EmailConfigurator
    {
        public string From { get; set; } 
        public string UserName { get; set; }
        public string Password { get; set; }
        public int Port { get; set; }
        public string SmtpServer { get; set; }
    }
}
