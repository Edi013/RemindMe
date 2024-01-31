using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using RemindMe.Application.Handlers.Todos;
using RemindMe.DataAcces;
using RemindMe.DataAcces.Repositories;
using RemindMe.Domain.Interfaces;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Text;

namespace RemindMe
{
    public static class BuilderExtensions
    {
        public static void RegisterServices(this WebApplicationBuilder builder)
        {
            builder.ConfigureLogging();


            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();

            builder.ConfigureCors();

            builder.RegisterSwaggerSettings();

            builder.Services.AddMediatR(
                 cfg => cfg.RegisterServicesFromAssemblies(typeof(GetAllTodoHandler).Assembly));

            var connectionString = builder.Configuration.GetConnectionString("RemindMeDb");
            builder.Services.AddDbContext<ApplicationDbContext>(options => options.UseNpgsql(connectionString));

            /*var audience = new List<string>{
                            builder.Configuration.GetSection("JWT:ValidAudience:Postman").Value,
                            builder.Configuration.GetSection("JWT:ValidAudience:FlutterClient").Value,
                            builder.Configuration.GetSection("JWT:ValidAudience:TodoService").Value,
            };
            builder.Services
                .AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(options =>
                {
                    options.SaveToken = true;
                    options.RequireHttpsMetadata = false;
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        RequireExpirationTime = true,
                        ValidIssuer = builder.Configuration.GetSection("JWT:ValidIssuer").Value,
                        ValidAudiences = audience,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                            builder.Configuration.GetSection("JWT:Secret").Value)),
                        ClockSkew = TimeSpan.Zero
                    };
                }
            );
            ;*/

            builder.RegisterAppSettings();
            builder.Services.AddScoped<ITodoRepository, TodoRepository>();
        }
        public static void ConfigureLogging(this WebApplicationBuilder builder)
        {
            builder.Logging.ClearProviders();
            builder.Logging.AddLog4Net(log4NetConfigFile: "log4net.config");
        }

        private static void ConfigureCors(this WebApplicationBuilder builder)
        {
            string[] authorizedUrls = new string[] { };
            authorizedUrls.Append(builder.Configuration.GetSection("AuthorizedUrls:EmailingService").Value);
            authorizedUrls.Append(builder.Configuration.GetSection("AuthorizedUrls:FrontendAppUrl").Value);
            
            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: "TodoPolicy",
                                          policy =>
                                          {
                                              policy.WithOrigins(builder.Configuration.GetSection("FrontendApp:Url").Value)
                                              .AllowAnyHeader()
                                              .AllowAnyMethod()
                                              .AllowCredentials();
                                          });
            });
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
