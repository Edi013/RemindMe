using RemindMe;
using System.Net;


var builder = WebApplication.CreateBuilder(args);

builder.RegisterServices();

var app = builder.Build();

app.ApplyConfiguration();

