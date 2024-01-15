using Microsoft.AspNetCore.Identity;

namespace RemindMe.Authentication.Domain.Models
{
    public class User : IdentityUser
    {
        // Non unique username
        public string Username { get; set; }
    }
}
