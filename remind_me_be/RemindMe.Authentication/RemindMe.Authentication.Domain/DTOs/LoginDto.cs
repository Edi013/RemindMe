using System.ComponentModel.DataAnnotations;

namespace RemindMe.Authentication.Domain.DTOs
{
    public class LoginDto
    {

        [EmailAddress]
        [Required(ErrorMessage = "Email is required")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        public string Password { get; set; }
    }
}
