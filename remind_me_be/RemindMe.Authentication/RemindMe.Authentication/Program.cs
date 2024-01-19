using RemindMe;
using System.Net;


var builder = WebApplication.CreateBuilder(args);

builder.RegisterServices();

var app = builder.Build();

app.ApplyConfiguration();

Host.CreateDefaultBuilder(args)
        .ConfigureWebHostDefaults(webBuilder =>
        {
            webBuilder.UseStartup<Program>();
            webBuilder.ConfigureKestrel(options =>
            {
                options.Listen(IPAddress.Any, 443, listenOptions =>
                {
                    listenOptions.UseHttps("C:\\openssl\\certificate.crt", "C:\\openssl\\private.key");
                });
            });
        });

