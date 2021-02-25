FROM mcr.microsoft.com/dotnet/core/sdk:6.0-focal AS build
WORKDIR /app

COPY webapp/*.csproj ./
RUN dotnet restore

COPY webapp/. ./
RUN dotnet publish -c Release -o out

ENV ASPNETCORE_URLS http://*:$PORT

FROM mcr.microsoft.com/dotnet/core/aspnet:6.0-focal AS runtime

WORKDIR /app
COPY --from=build /app/out ./
#ENTRYPOINT ["dotnet", "webapp.dll"]
CMD dotnet webapp.dll
