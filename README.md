# RemindMe 
## A cross-platform application built on Microservices

# Setup guide
## Frontend
1. Install Visual Studio Code and Flutter Extension.
2. Install Flutter.
3. Start the project from VS Code.
---START--- 
For launch.json configuration you can use this file :
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Web Flutter ",
            "request": "launch",
            "type": "dart",
            "args": ["-d", "chrome","--web-port", "51742"],
        },
        {
            "name": "Windows Flutter",
            "request": "launch",
            "type": "dart",
            "args": ["-d", "windows","--web-port", "51742"],
        },
    ]
}
---END---

## Backend
1. Install Visual Studio & .NET from the Visual Studio Installer.
2. 1. Do all steps within Database section
2. 2. Apply the migrations (if they were not applied automatically) with 'update-database' command in Nuget Package Manager Console.
3. 1. Open and start each microservice.
3. 2. Authentication microserivce needs to have roles seeded in the database : Call the api found on route   'http://localhost:7092/Authentication/SeedRoles'.

## Database
1. Install Docker
2. Use 'docker-compose up' command on docker compose files, there is one for each microservice (1 database per microservice).