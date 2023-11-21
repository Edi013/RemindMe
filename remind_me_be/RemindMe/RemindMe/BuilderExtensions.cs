using Microsoft.EntityFrameworkCore;
using RemindMe.Application.Handlers.ToDos;
using RemindMe.DataAcces;
using RemindMe.DataAcces.Repositories;
using RemindMe.Domain.Interfaces;

namespace RemindMe
{
    public static class BuilderExtensions
    {
        public static void RegisterServices(this WebApplicationBuilder builder)
        {
            builder.ConfigureLogging();

            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();

            builder.RegisterSwaggerSettings();

            builder.Services.AddMediatR(
                 cfg => cfg.RegisterServicesFromAssemblies(typeof(GetAllToDoHandler).Assembly));

            var connectionString = builder.Configuration.GetConnectionString("RemindMeDb");
            builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseNpgsql(connectionString));

            builder.Services.AddScoped<IToDoRepository, ToDoRepository>();

            builder.RegisterAppSettings();
        }
        public static void ConfigureLogging(this WebApplicationBuilder builder)
        {
            builder.Logging.ClearProviders();
            builder.Logging.AddLog4Net(log4NetConfigFile: "log4net.config");
        }

        private static void RegisterSwaggerSettings(this WebApplicationBuilder builder)
        {
            builder.Services.AddSwaggerGen();
        }
        
        private static void RegisterAppSettings(this WebApplicationBuilder builder)
        {
            var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .Build();
            builder.Services.AddSingleton(configuration);
        }
    }
}
