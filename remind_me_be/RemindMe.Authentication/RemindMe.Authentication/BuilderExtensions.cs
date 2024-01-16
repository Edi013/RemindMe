using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using RemindMe.Authentication.DataAccess;
using RemindMe.Authentication.Domain.Interfaces.EmailingSystem;
using RemindMe.Authentication.Domain.Models;
using RemindMe.Authentication.Domain.Models.EmailingSystem;
using RemindMe.Authentication.Handlers;
using RemindMe.Authentication.Notifications;

namespace RemindMe
{
    public static class BuilderExtensions
    {
        public static void RegisterServices(this WebApplicationBuilder builder)
        {
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();

            builder.ConfigureCors();

            builder.Services.AddSwaggerGen();

            var connectionString = builder.Configuration.GetConnectionString("RemindMeAuthenticationDb");
            builder.Services.AddDbContext<AuthenticationDbContext>(options => 
                options.UseNpgsql(connectionString));

            builder.Services.AddScoped<AuthenticationHandler, AuthenticationHandler>();

            builder.RegisterAppSettings();

            builder.Services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
                .AddJwtBearer(options =>
                {
                    /*options.TokenValidationParameters = new TokenValidationParameters
                    {
                        // Specify the key used to sign the JWT. This should match the key used during token creation.
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes("your_secret_key")),

                        // Validate the token issuer (optional)
                        ValidateIssuer = true,
                        ValidIssuer = "your_issuer",

                        // Validate the token audience (optional)
                        ValidateAudience = true,
                        ValidAudience = "your_audience",

                        // Validate the token expiration time (required)
                        ValidateLifetime = true,

                        // Clock skew allows for some time drift between the server and client. Adjust as needed.
                        ClockSkew = TimeSpan.Zero
                    };*/
                })
                .AddCookie(options =>
                    {
                        options.Cookie.Name = "JWT";
                    });

            builder.ConfigureIdentityPassword();

            //Add email configs
            var emailConfig = builder.Configuration.GetSection("EmailingSystem").Get<EmailConfigurator>();
            builder.Services.AddSingleton(emailConfig);

            builder.Services.AddScoped<IEmailService, EmailService>();
        }
        private static void ConfigureIdentityPassword(this WebApplicationBuilder builder)
        {
            builder.Services.AddIdentity<User, IdentityRole>(x =>
            {
                x.Password.RequiredLength = 8;
                x.Password.RequireUppercase = true;
                x.Password.RequireLowercase = true;
                x.Password.RequireDigit = true;
                x.Password.RequireNonAlphanumeric = true;

                x.User.RequireUniqueEmail = true;
            })
                .AddEntityFrameworkStores<AuthenticationDbContext>()
                .AddDefaultTokenProviders(); ;
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
