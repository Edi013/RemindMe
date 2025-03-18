# RemindMe 
A cross-platform application for taking notes.
It uses Flutter, .NET and PostgreSQL, being built on Microservices.

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
3. Open and start each microservice.

## Database
1. Install Docker
2. Use 'docker-compose up' command on docker compose files, there is one for each microservice (1 database per microservice).

Todos microservice database diagram. Observe the usage of weak foreign keys : OwnerId row references data that is located in another database, another environment.
![DB Diagram todos](https://github.com/user-attachments/assets/e5601548-98d4-40c3-afc4-60161d271c6f)

## Architecture

### Overall diagram
![client - server 3 to 3](https://github.com/user-attachments/assets/5a78a651-b2d0-4693-9bed-0f79a64bbded)

### Backend microservices diagram
![backend diagrams ](https://github.com/user-attachments/assets/5f2dfab6-583f-46ff-9824-ad663932b8be)

## Features
 
1. Authentication : Login and Register
2. Session persistance: JWT-Login session that persist for a few days, even if the auth microservice is offline.
3. Core functionality: 
	- Take notes, create deadlines, assign a difficuly.
	- Update or delete the todos' status upon finalization. Finish a task with success or miss the deadline, real-life interpretation. 
	- Search todos by title
	- Use pre-created screens to quickly divide the data by main clusters : done/undone and ongoing/not ongoing todos.
	- Use markup language when taking notes. Bold, italic, titles, bullet point, etc.
4. Support for both, landscape and portrait views.

Landscape view :

![landscape todos](https://github.com/user-attachments/assets/3f372d30-5f05-4407-950b-db52c411841d)

Portrait view :

![portrait todos](https://github.com/user-attachments/assets/be27bb29-b164-4701-813c-b98428fb205b)

As Flutter already is a cross-platform tool, with the 4th feature added, this software should run on any operating system, any device size, so any device.

5. Home screen configuration: Select what your home screen will display. 
6. Theme configuration: 
	- manually pick one of the 2 themes that are present (night/dark and day/light)
	- use the system default

![portrait theme config](https://github.com/user-attachments/assets/bbe4f527-f839-4bc7-984c-53ad88e1ec05)

7. Settings persistance: Selected home screen and theme will persist on the device they are configured.
8. User account details. The app always displays what data it has stored about the user.
   
![landscape account details](https://github.com/user-attachments/assets/338111b0-5064-4b16-86c9-b1622079ed22)
