# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /

# Copy everything
COPY . ./
# Restore and publish the application
RUN dotnet restore
RUN mkdir -p out
RUN dotnet publish -c Debug -o out  # specify output directory as "out"

# Stage 2: Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR .

# Create the out directory if it doesn't exist

COPY --from=build-env /out ./out

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "RemindMe.ToDo.dll"]  # Replace "RemindMe.ToDo.dll" with the actual name of your application's DLL
