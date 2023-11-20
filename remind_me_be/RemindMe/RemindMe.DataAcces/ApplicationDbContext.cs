using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Domain.Entities;
using System.Reflection.Emit;

namespace RemindMe.DataAcces
{
    public class ApplicationDbContext : DbContext
    {
        private IConfiguration Configuration;
        public DbSet<ToDo> ToDos { get; set; }

        public ApplicationDbContext(IConfiguration _configuration)
        {
            Configuration = _configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            base.OnConfiguring(options);

            options.UseNpgsql(Configuration.GetConnectionString("RemindMeDb"));
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            ConfigureToDo(modelBuilder);

            base.OnModelCreating(modelBuilder);
        }

        private void ConfigureToDo(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ToDo>().HasKey(x => x.Id);
        }
    }
}