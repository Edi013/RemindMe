using Microsoft.EntityFrameworkCore.Internal;
using RemindMe.Application.Requests;

namespace RemindMe
{
    public static class Startup
    {
        public static void RegisterServices(WebApplicationBuilder builder)
        {
            builder.RegisterServices();
        }

        public static void ApplyAppConfiguration(WebApplication app)
        {
            app.UseSwager();

            app.ApplyAppConfiguration();
        }
    }
}
