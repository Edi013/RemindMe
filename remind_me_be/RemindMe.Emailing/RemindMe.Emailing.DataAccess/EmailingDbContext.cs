using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Emailing.Domain.Models;

namespace RemindMe.Emailing.DataAccess
{
    public class EmailingDbContext : DbContext
    {
        private IConfiguration _configuration;

        public EmailingDbContext(DbContextOptions<EmailingDbContext> options, IConfiguration configuration) :
            base(options)
        {
            _configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            var a = _configuration.GetConnectionString("RemindMeEmailingDb");
            options.UseNpgsql(a);

            base.OnConfiguring(options);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            ConfigureEmailingUserActivity(modelBuilder);
            base.OnModelCreating(modelBuilder);
        }

        private void ConfigureEmailingUserActivity(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<EmailingUserActivity>().ToTable("EmailingUserActivity");
            modelBuilder.Entity<EmailingUserActivity>().HasKey(x => x.Id);
            
            modelBuilder.Entity<EmailingUserActivity>().Property(x => x.UserId).IsRequired();
            modelBuilder.Entity<EmailingUserActivity>().Property(x => x.Dates).IsRequired();
            modelBuilder.Entity<EmailingUserActivity>().Property(x => x.EmailsSent).IsRequired();
        }
    }
}
