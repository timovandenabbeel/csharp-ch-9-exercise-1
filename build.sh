mkdir tempdir
mkdir tempdir/src

cp -r src/* tempdir/src/.

cat > tempdir/Dockerfile << _EOF_
# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app
    
# Copy csproj and restore as distinct layers
ADD ./src ./src
RUN dotnet restore ./src/Server/Server.csproj
RUN dotnet publish ./src/Server/Server.csproj -c Release -o out
    
# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Server.dll"]
_EOF_

cd tempdir || exit
docker build -t csharp_app .
