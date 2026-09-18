# Clinic Management System (CMS) — Frontend Application

Modern, multi-role Single-Page Application (SPA) built with **Angular 14**, **Bootstrap 5**, and **SCSS** for the Clinic Management System.

---

## 📖 Complete Documentation
For full architectural details, component hierarchy, role workflows, and module inventory:
- 👉 **[FRONTEND_ARCHITECTURE_AND_WORKFLOW.md](./FRONTEND_ARCHITECTURE_AND_WORKFLOW.md)**

---

## 🚀 Quick Start Guide

### 1. Prerequisites
- **Node.js**: `v16.x` or `v18.x`
- **npm**: `v8.x` or higher
- **Angular CLI**: `^14.0.0` (or use local `npx ng`)

### 2. Install Dependencies
```bash
npm install
```

### 3. Start Development Server
```bash
npm start
# or
npx ng serve
```
Navigate to: **[http://localhost:4200/](http://localhost:4200/)**

### 4. Build for Production
```bash
npm run build
```
Compiled output will be generated in `dist/`.

---

## 🏗️ Architecture & Modules

| Module Directory | Role / Function | Lazy Loaded Route |
| :--- | :--- | :--- |
| `src/app/auth/` | Login, Role Dashboards, Navbar, Auth Guard | `/login`, `/auth` |
| `src/app/admin/` | Staff management, Department assignments | `/admin` |
| `src/app/doctor/` | Patient consultations, Diagnosis, Lab/Med prescription | `/doctor` |
| `src/app/doctormgmt/`| Doctor schedule, Specializations, Consultation fees | `/doctormgmt` |
| `src/app/receptionists/`| Patient registration, Token issue, Doctor appointment booking, Outpatient billing | `/receptionists` |
| `src/app/pharmacists/`| Medicine dispensary, Inventory management, Prescription fulfillment, Pharmacy billing | `/pharmacists` |
| `src/app/lab/` & `labtechnicians/` | Lab investigations, Sample collection, Test results, Lab billing | `/lab`, `/labtechnicians` |
| `src/app/medicine-managements/` | Central pharmacy catalog & stock levels | `/medicine-managements` |
| `src/app/uregistration/` | System user authentication credentials | `/uregistration` |
| `src/app/shared/` | Shared domain models, HTTP client services, interceptors | Common singleton |

---

## 🔌 Backend Connectivity
The frontend communicates with the ASP.NET Core Web API:
- Endpoint configured in: `src/environments/environment.ts`
- Base URL: `https://localhost:7201/api/` (or `http://localhost:5124/api/`)
