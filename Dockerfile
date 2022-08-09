#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/Server/Server.csproj", "src/Server/"]
COPY ["src/Shared/Shared.csproj", "src/Shared/"]
COPY ["src/Services/Services.csproj", "src/Services/"]
COPY ["src/Domain/Domain.csproj", "src/Domain/"]
COPY ["src/Persistence/Persistence.csproj", "src/Persistence/"]
COPY ["src/Client/Client.csproj", "src/Client/"]
RUN dotnet restore "src/Server/Server.csproj"
COPY . .
WORKDIR "/src/src/Server"
RUN dotnet build "Server.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Server.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Server.dll"]