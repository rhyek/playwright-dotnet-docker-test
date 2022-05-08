FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["PlaywrightNetDockerTest.csproj", "./"]
RUN dotnet restore "PlaywrightNetDockerTest.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "PlaywrightNetDockerTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PlaywrightNetDockerTest.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/playwright/dotnet:v1.21.0-focal
RUN apt-get update; \
  apt-get install -y dumb-init
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["dotnet", "PlaywrightNetDockerTest.dll"]
