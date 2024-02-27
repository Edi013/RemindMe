using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using RemindMe.Domain.Entities;

namespace RemindMe.DataAcces
{
    public class ApplicationDbContext : DbContext
    {
        private IConfiguration Configuration;
        public DbSet<Item> Todos { get; set; }

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
            ConfigureTodo(modelBuilder);

            base.OnModelCreating(modelBuilder);
        }

        private void ConfigureTodo(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Item>()
                .HasKey(x => x.Id);
            
            
            modelBuilder.Entity<Item>()
                .Property(x => x.Title)
                .IsRequired()
                .HasMaxLength(100);

            modelBuilder.Entity<Item>()
                .Property(x => x.Description)
                .IsRequired()
                .HasMaxLength(10000);

            modelBuilder.Entity<Item>()
                .Property(x => x.CreationDate)
                .IsRequired();

            modelBuilder.Entity<Item>()
                .Property(x => x.StartDate)
                .IsRequired();

            modelBuilder.Entity<Item>()
                .Property(x => x.IsFinished)
                .IsRequired();

            modelBuilder.Entity<Item>()
                .Property(x => x.Difficulty)
                .IsRequired();

            modelBuilder.Entity<Item>()
                .Property(x => x.OwnerId)
                .IsRequired();
        }
    }
}