# Clinic Management System (CMS) — Database Directory

This directory contains the complete database scripts, tables DDL, seed data, stored procedures, views, and functions for the **Clinic Management System (CMS)** backend.

---

## 📁 File Structure & Execution Order

| File | Purpose | Description |
|---|---|---|
| **`00_MASTER_CMS_DATABASE.sql`** | **One-Click Master Script** | Executes the entire database setup (Database, 29 Tables, Seed Data, SPs, Views, Functions) in a single run. |
| **`01_CREATE_DATABASE_AND_TABLES.sql`** | **DDL Schema Script** | Creates `ClinicManagementSys` database and all 29 relational tables with PKs, FKs, identity columns, and computed columns. |
| **`02_INSERT_SEED_DATA.sql`** | **Master & Seed Data** | Populates lookup tables (Roles, Departments, Specializations, Weekdays, Statuses), staff, doctor profiles, logins, lab tests, and medicines. |
| **`03_STORED_PROCEDURES.sql`** | **Stored Procedures** | Core operational stored procedures for authentication, booking, auto-token generation, lab reporting, and pharmacy dispensing. |
| **`04_VIEWS_AND_FUNCTIONS.sql`** | **Views & Functions** | Analytical views for doctor timetables, appointments, lab queue, inventory stock alerts, and financial summaries. |
| **`05_ALTER_PASSWORD_TO_HASH.sql`** | **Migration Script** | Expands `LoginRegistration.Password` to `VARCHAR(128)` to safely store industrial salted BCrypt password hashes. |

---

## 🚀 Quick Setup Instructions

### Option 1: Execute Master Script via SQLCMD (Terminal)
Open PowerShell or Command Prompt and run:
```powershell
sqlcmd -S ".\SQLEXPRESS" -E -i "00_MASTER_CMS_DATABASE.sql"
```

### Option 2: Execute in SQL Server Management Studio (SSMS)
1. Open **SSMS** and connect to your SQL Server instance (e.g. `.\SQLEXPRESS` or `(local)`).
2. Open `00_MASTER_CMS_DATABASE.sql` (or run files `01` through `04` in numeric sequence).
3. Click **Execute** (or press `F5`).

---

## 🗄️ Relational Schema Breakdown (29 Tables)

### 1. Identity & Staff Administration
- **`Role`**: User access roles (`Admin`, `Doctor`, `Receptionist`, `Pharmacist`, `Lab Technician`).
- **`department`**: Clinic departments (`Cardiology`, `Neurology`, `Orthopedics`, `Administration`, `Pharmacy`, `Laboratory`, `Reception`, `HR`, `General`).
- **`staff`**: Staff personal details, contact info, department mapping, date of joining, salary.
- **`LoginRegistration`**: Application credentials (`Username`, `Password`), linked to `Role` and `staff`.

### 2. Doctors & Scheduling
- **`specialization`**: Medical disciplines (`Cardiologist`, `Neurologist`, `Orthopedicsist`, `General`).
- **`doctor`**: Doctor profile linked to `LoginRegistration`, `specialization`, consultation fee, and active status.
- **`weekdays`**: Days of the week (`Monday` through `Sunday`).
- **`timeslot`**: Consultation start and end times mapped to weekdays.
- **`availability`**: Doctor time slot allocation and session (`Morning`, `Evening`).
- **`DailyAvailability`**: Real-time slot availability tracking per appointment date.

### 3. Patient Desk & Appointments
- **`Patient`**: Patient demographics, blood group, phone number, address, registration date.
- **`AppointmentStatus`**: Status values (`1: Success / Confirmed`, `2: Pending / Scheduled`).
- **`Appointment`**: Appointments linking patient, doctor, date, timeslot, status, token number, registration fee (default 150.00), and doctor consultation fee.
- **`BillStatus`**: Status values (`1: Paid`, `2: Unpaid`).
- **`PatientBill`**: Outpatient consultation invoice with computed total fee: `[ConsultationFee] + [RegistrationFee]`.

### 4. Clinical Diagnosis & Prescriptions
- **`StartDiagnosys`**: Clinical consultation records: doctor notes, symptoms, diagnosis, follow-up visiting date, appointment reference.
- **`Prescription`**: Prescribed medications, dosage instructions, frequency, and number of days.
- **`TestPrescription`**: Laboratory investigation orders linked to an appointment with sample item type (Blood, Urine, etc.).

### 5. Pharmacy & Inventory Management
- **`Category`**: Drug classification (`Syrup`, `Tablet`, `Injection`, `Capsule`).
- **`MedicineDetails`**: Drug details, unit cost, manufacturing date, expiry date, category, active status.
- **`MedicineInventory`**: Stock tracking (`StockInHand`, `ReOrderLevel`, `Purchase`, `Issuance`, `IsActive`).
- **`MedDistributionStatus`**: Dispensing billing status (`1: Paid`, `2: Unpaid`).
- **`MedicineDistribution`**: Dispensed medicines linked to a prescription and quantity distributed.
- **`MedicineBillStatus`**: Payment status (`1: Paid`, `2: Unpaid`).
- **`MedicineBill`**: Pharmacy invoice for dispensed medications.

### 6. Diagnostics & Laboratory
- **`Labtest`**: Master catalog of lab investigations with normal low/high ranges, specimen type, and test price.
- **`LabTestReport`**: Diagnostic results: low range, high range, actual observed result, pathologist remarks.
- **`LabTestBillStatus`**: Diagnostic billing status (`1: Paid`, `2: Unpaid`).
- **`LabTestBill`**: Diagnostic invoice for completed lab tests.

---

## ⚡ Stored Procedures Catalog

| Stored Procedure | Parameters | Description |
|---|---|---|
| **`sp_AuthenticateUser`** | `@Username`, `@Password` | Authenticates login credentials and returns user identity, role, department, and doctor profile. |
| **`sp_RegisterPatient`** | `@PatientName`, `@DOB`, `@Gender`, `@BloodGroup`, `@PatientPhone`, `@PatientAddress`, `@NewPatientId OUTPUT` | Registers a new patient with unique phone verification. |
| **`sp_BookAppointment`** | `@PatientId`, `@DoctorId`, `@SpecializationId`, `@AppointmentDate`, `@AvailabilityId`, `@NewAppointmentId OUTPUT`, `@GeneratedToken OUTPUT` | Transactionally books an appointment, auto-increments the daily token number, sets default registration fee, marks daily availability, and creates `PatientBill`. |
| **`sp_GetDoctorAvailabilityByDate`** | `@DoctorId`, `@Date` | Resolves the weekday from `@Date` and retrieves matching active schedule slots for the doctor. |
| **`sp_GetTodaysPrescribedTests`** | *(None)* | Retrieves the active daily lab queue with patient demographics, doctor, and reference range benchmarks. |
| **`sp_CreateLabTestReportAndBill`** | `@AppointmentId`, `@LabTestId`, `@ActualResult`, `@Remarks`, `@NewReportId OUTPUT`, `@NewBillId OUTPUT` | Transactionally inserts the test report outcome and auto-generates the corresponding `LabTestBill`. |
| **`sp_DispenseMedicineAndBill`** | `@PrescriptionId`, `@Quantity`, `@Remarks`, `@NewMedDistId OUTPUT`, `@NewMedBillId OUTPUT` | Validates inventory levels, deducts stock, creates `MedicineDistribution`, and generates `MedicineBill`. |
| **`sp_GetPatientBillSummary`** | `@AppointmentId` | Aggregates all billing components (Consultation, Diagnostics, Pharmacy) for an appointment. |

---

## 📊 Analytical Views & Functions

- **`vw_DoctorSchedules`**: Real-time doctor timetable view with specializations, consulting fees, weekday schedules, and session times.
- **`vw_PatientAppointments`**: Comprehensive appointment list showing patient age, doctor name, token number, fees, and payment status.
- **`vw_LabTestWorklist`**: Laboratory investigation queue with specimen types and completion status.
- **`vw_MedicineStockStatus`**: Pharmacy stock monitor with inventory status (`SUFFICIENT`, `LOW STOCK - REORDER`, `OUT OF STOCK`) and expiry alerts.
- **`vw_DailyClinicRevenue`**: Consolidated daily revenue report combining consultation, pharmacy, and diagnostic receipts.
- **`fn_CalculatePatientAge(@DOB)`**: Scalar function calculating exact patient age in years.
- **`fn_GetNextTokenNumber(@DoctorId, @Date)`**: Scalar function returning the next sequential token number.
