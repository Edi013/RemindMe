using RemindMe;

var builder = WebApplication.CreateBuilder(args);

Startup.RegisterServices(builder);

var app = builder.Build();

Startup.ApplyAppConfiguration(app);


