using System.ComponentModel.DataAnnotations;

namespace RemindMe.Authentication.Domain.DTOs
{
    public class LoginDto
    {
        [EmailAddress]
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
