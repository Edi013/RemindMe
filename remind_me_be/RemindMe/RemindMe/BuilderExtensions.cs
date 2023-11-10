using RemindMe.Application.Requests;

namespace RemindMe
{
    public static class BuilderExtensions
    {
        public static void RegisterServices(this WebApplicationBuilder builder)
        {
            builder.RegisterSwaggerSettings();

            builder.RegisterAppSettings();

            builder.Services.AddMediatR(
                 cfg => cfg.RegisterServicesFromAssemblies(
                 typeof(WeatherForecastRequest).Assembly));
        }

        private static void RegisterSwaggerSettings(this WebApplicationBuilder builder)
        {
            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();
        }
        
        private static void RegisterAppSettings(this WebApplicationBuilder builder)
        {
            var configuration = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .Build();
            builder.Services.AddSingleton(configuration);
        }
        
        public static void ApplyAppConfiguration(this WebApplication app)
        {
            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }

        public static void UseSwager(this WebApplication app)
        {
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
        }
    }
}
