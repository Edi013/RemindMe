namespace RemindMe
{
    public static class WebApplicationExtensions
    {
        public static void ApplyConfiguration(this WebApplication app)
        {
           /* if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }*/

            app.UseHttpsRedirection();

            app.UseCors("AuthenticationPolicy");

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });


            app.Run();
        }
    }
}
