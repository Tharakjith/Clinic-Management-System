@echo off
cd /d "%~dp0Backend"
dotnet run --project ClinicManagementSys/ClinicManagementSys.csproj --urls "http://localhost:5124;https://localhost:7201"
