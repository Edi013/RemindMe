using RemindMe;

var builder = WebApplication.CreateBuilder(args);

builder.RegisterServices();

LogStartup.LogStartupInformation();

var app = builder.Build();

app.ApplyConfiguration();


