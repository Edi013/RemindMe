using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Domain.Entities;

namespace RemindMe.DataAcces
{
    public class ApplicationDbContext : DbContext
    {
        private IConfiguration Configuration;
        public DbSet<ToDo> ToDos { get; set; }

        public ApplicationDbContext() { }

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
            modelBuilder.Entity<ToDo>()
                .HasKey(x => x.Id);
            
            
            modelBuilder.Entity<ToDo>()
                .Property(x => x.Title)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<ToDo>()
                .Property(x => x.Description)
                .IsRequired()
                .HasMaxLength(10000);

            modelBuilder.Entity<ToDo>()
                .Property(x => x.CreationDate)
                .IsRequired();

            modelBuilder.Entity<ToDo>()
                .Property(x => x.StartDate)
                .IsRequired();

            modelBuilder.Entity<ToDo>()
                .Property(x => x.IsFinished)
                .IsRequired();

            modelBuilder.Entity<ToDo>()
                .Property(x => x.Difficulty)
                .IsRequired();

            modelBuilder.Entity<ToDo>()
                .Property(x => x.OwnerId)
                .IsRequired();
        }
    }
}