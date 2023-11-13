using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Domain.Entities;

namespace RemindMe.DataAcces
{
    public class AppDbContext : DbContext
    {
        private IConfiguration Configuration;

        public AppDbContext(IConfiguration _configuration)
        {
            Configuration = _configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            base.OnConfiguring(options);

            options.UseNpgsql(Configuration.GetConnectionString("RemindMeDb"));
        }

        public DbSet<ToDo> ToDos { get; set; }
    }
}
