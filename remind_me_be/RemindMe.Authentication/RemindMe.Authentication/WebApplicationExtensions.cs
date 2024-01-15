namespace RemindMe
{
    public static class WebApplicationExtensions
    {
        public static void ApplyConfiguration(this WebApplication app)
        {
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseCors("AuthenticationPolicy");

            //app.UseRouting();
            app.UseAuthorization();
            //app.UseEndpoints();

            app.MapControllers();

            app.Run();
        }
    }
}
