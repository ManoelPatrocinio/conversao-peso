# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

COPY *.sln .
COPY ConversaoPeso.Web/*.csproj ./ConversaoPeso/
RUN dotnet restore

COPY ConversaoPeso.Web/. ./ConversaoPeso/
WORKDIR /app
RUN dotnet publish -c release -o /app --no-restore


FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=build /app ./
CMD ["dotnet", "aspnetapp.dll"]