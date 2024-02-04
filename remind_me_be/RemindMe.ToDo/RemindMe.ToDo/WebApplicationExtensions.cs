using log4net;

namespace RemindMe
{
    public static class WebApplicationExtensions
    {
        public static void ApplyConfiguration(this WebApplication app)
        {
            app.UseSwager();


            app.UseCors("TodoPolicy");

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

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
