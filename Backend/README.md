# Clinic Management System (CMS) — Backend Solution

Welcome to the backend service for the **Clinic Management System (CMS)**.

## 📖 Complete Documentation
For full architectural details, ER diagrams, layer breakdown, and endpoint specifications, please read:
- 👉 **[BACKEND_ARCHITECTURE.md](./BACKEND_ARCHITECTURE.md)**

---

## 🚀 Quick Start Guide

### 1. Prerequisites
- **.NET 6.0 SDK** or higher
- **Microsoft SQL Server Express** with `ClinicManagementSys` database attached / restored.

### 2. Build the API
```powershell
dotnet build
```

### 3. Run the API
```powershell
dotnet run --project ClinicManagementSys/ClinicManagementSys.csproj
```

### 4. Endpoints & Swagger Documentation
Once the server is running:
- **Swagger UI**: [http://localhost:5124/swagger/index.html](http://localhost:5124/swagger/index.html)
- **HTTPS Endpoint**: `https://localhost:7201`
- **HTTP Endpoint**: `http://localhost:5124`

### 5. Quick Verification
```powershell
# Query patients
Invoke-RestMethod -Uri "http://localhost:5124/api/Receptions"

# Query weather forecast sample
Invoke-RestMethod -Uri "http://localhost:5124/WeatherForecast"
```