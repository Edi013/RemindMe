using Microsoft.EntityFrameworkCore;
using RemindMe.Emailing.Business;
using RemindMe.Emailing.DataAccess;
using RemindMe.Emailing.Domain.Interfaces;
using RemindMe.Emailing.Domain.Models;

namespace RemindMe.Emailing
{
    public static class BuilderExtensions
    {
        public static void RegisterServices(this WebApplicationBuilder builder)
        {
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();

            builder.ConfigureCors();

            builder.Services.AddSwaggerGen();

            var connectionString = builder.Configuration.GetConnectionString("RemindMeEmailingDb");
            builder.Services.AddDbContext<EmailingDbContext>(options => 
                options.UseNpgsql(connectionString));


            builder.RegisterAppSettings();

            var emailConfig = builder.Configuration.GetSection("EmailingSystem").Get<EmailConfigurator>();
            builder.Services.AddSingleton(emailConfig);

            builder.Services.AddScoped<EmailingHandler, EmailingHandler>();
            builder.Services.AddScoped<IEmailService, EmailService>();
            builder.Services.AddScoped<IRepository, EmailingUserActivityRepository>();
        }

        private static void RegisterAppSettings(this WebApplicationBuilder builder)
        {
            var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .Build();
            builder.Services.AddSingleton(configuration);
        }

        private static void ConfigureCors(this WebApplicationBuilder builder)
        {
            string[] authorizedUrls = new string[] { };
            authorizedUrls.Append(builder.Configuration.GetSection("AuthorizedUrls:ToDoService").Value);
            authorizedUrls.Append(builder.Configuration.GetSection("AuthorizedUrls:FrontendAppUrl").Value);


            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: "EmailingPolicy",
                                          policy =>
                                          {
                                              policy.WithOrigins(authorizedUrls)
                                              .AllowAnyHeader()
                                              .AllowAnyMethod()
                                              .AllowCredentials();
                                          });
            });
        }
    }
}
