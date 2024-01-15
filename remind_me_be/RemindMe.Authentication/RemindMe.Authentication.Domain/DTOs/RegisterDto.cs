using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace RemindMe.Authentication.Domain.DTOs
{
    public class RegisterDto
    {
        public string Username { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        public string Password { get; set; }    
    }
}
