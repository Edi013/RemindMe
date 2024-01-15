using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Authentication.Domain.Models;
using System.Data;

namespace RemindMe.Authentication.DataAccess
{
    public class AuthenticationDbContext : IdentityDbContext<User>
    {
        private IConfiguration _configuration;

        public AuthenticationDbContext(DbContextOptions<AuthenticationDbContext> options, IConfiguration configuration) :
            base(options)
        {
            _configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            var a = _configuration.GetConnectionString("RemindMeAuthenticationDb");
            options.UseNpgsql(a);

            base.OnConfiguring(options);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
    }
}
