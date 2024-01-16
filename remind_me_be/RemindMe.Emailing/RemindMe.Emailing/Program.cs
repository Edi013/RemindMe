using RemindMe.Emailing;

var builder = WebApplication.CreateBuilder(args);

builder.RegisterServices();

var app = builder.Build();

app.ApplyConfiguration();

