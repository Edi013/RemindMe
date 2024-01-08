using log4net;

namespace RemindMe
{
    public static class WebApplicationExtensions
    {
        public static void ApplyConfiguration(this WebApplication app)
        {
            

            app.UseSwager();

            app.UseHttpsRedirection();

            app.UseCors("CorsPolicy");

            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }

        private static void UseSwager(this WebApplication app)
        {
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
        }
    }
}
