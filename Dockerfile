FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /Estudos

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY . .
RUN dotnet restore 
RUN dotnet build --no-restore -c Release -o /Estudos

FROM build AS publish
RUN dotnet publish --no-restore -c Release -o /Estudos

FROM base AS final
WORKDIR /Estudos
COPY --from=publish /Estudos .
# Padrão de container ASP.NET
# ENTRYPOINT ["dotnet", "CarterAPI.dll"]
# Opção utilizada pelo Heroku
CMD ASPNETCORE_URLS=http://*:$PORT dotnet estudos.dll