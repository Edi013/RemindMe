# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy everything
COPY . ./

# Restore and publish the application
RUN dotnet restore
RUN dotnet publish -c Debug -o out  # specify output directory as "out"

# Stage 2: Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

# Copy published output from Stage 1
COPY --from=build-env /app/out .

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "RemindMe.ToDo.dll"]
