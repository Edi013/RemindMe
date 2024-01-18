using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using RemindMe.Authentication.DataAccess;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models;
using RemindMe.Authentication.Domain.Models.EmailingSystem;
using RemindMe.Authentication.Handlers;
using RemindMe.Authentication.Notifications;
using System.Text;

namespace RemindMe
{
    public static class BuilderExtensions
    {
        public static void RegisterServices(this WebApplicationBuilder builder)
        {
            builder.ConfigureCors();

            var connectionString = builder.Configuration.GetConnectionString("RemindMeAuthenticationDb");
            builder.Services.
                AddDbContext<AuthenticationDbContext>(options => 
                    options.UseNpgsql(connectionString));

            builder.Services
                .AddIdentity<User, IdentityRole>(x =>
                {
                    x.Password.RequiredLength = 8;
                    x.Password.RequireUppercase = true;
                    x.Password.RequireLowercase = true;
                    x.Password.RequireDigit = true;
                    x.Password.RequireNonAlphanumeric = true;

                    x.User.RequireUniqueEmail = true;
                })
                .AddEntityFrameworkStores<AuthenticationDbContext>()
                .AddDefaultTokenProviders();

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
                        ValidIssuer = builder.Configuration.GetSection("JWT:Secret").Value,
                        ValidAudience = builder.Configuration.GetSection("JWT:Secret").Value,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(
                            builder.Configuration.GetSection("JWT:Secret").Value)),
                        ClockSkew = TimeSpan.Zero
                    };
                }
            );/*
                .AddCookie(options =>
                {
                        options.Cookie.Name = "JWT";
                });*/

            //Add email configs
            var emailConfig = builder.Configuration.GetSection("EmailingSystem").Get<EmailConfigurator>();
            builder.Services.AddSingleton(emailConfig);
            builder.Services.AddScoped<IEmailService, EmailService>();
            builder.Services.AddScoped<AuthenticationHandler, AuthenticationHandler>();
            builder.RegisterJsonConfigFile();

            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
        }

        private static void RegisterJsonConfigFile(this WebApplicationBuilder builder)
        {
            var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .Build();
            builder.Services.AddSingleton(configuration);
        }

        private static void ConfigureCors(this WebApplicationBuilder builder)
        {
            string[] authorizedUrls = new string[] { };
            authorizedUrls.Append(builder.Configuration.GetSection("AuthorizedUrls:FrontendAppUrl").Value);

            builder.Services.AddCors(options =>
            {
                options.AddPolicy(name: "AuthenticationPolicy",
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
