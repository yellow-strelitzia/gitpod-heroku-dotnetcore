FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /app

COPY webapp/*.csproj ./
RUN dotnet restore

COPY webapp/. ./
RUN dotnet publish -c Release -o out

ENV ASPNETCORE_URLS http://*:$PORT

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime

WORKDIR /app
COPY --from=build /app/out ./
#ENTRYPOINT ["dotnet", "webapp.dll"]
CMD dotnet webapp.dll
