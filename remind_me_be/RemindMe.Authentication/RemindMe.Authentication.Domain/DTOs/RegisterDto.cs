using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace RemindMe.Authentication.Domain.DTOs
{
    public class RegisterDto
    {
        [Required(ErrorMessage = "Nickname is required")]
        public string Nickname { get; set; }

        [EmailAddress]
        [Required(ErrorMessage = "Email is required")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        public string Password { get; set; }    
    }
}
