/*
================================================================================
   CLINIC MANAGEMENT SYSTEM (CMS) - SEED & MASTER DATA SCRIPT
   File: 02_INSERT_SEED_DATA.sql
   Target Database: ClinicManagementSys
   Description: Populates lookup tables, master data, staff, doctors,
                user credentials, sample patients, inventory, and lab tests.
================================================================================
*/

USE [ClinicManagementSys];
GO

-- ================================================================================
-- 1. ROLES
-- ================================================================================
SET IDENTITY_INSERT [dbo].[Role] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 1) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, 'Admin');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 2) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, 'Doctor');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 3) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, 'Receptionist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 4) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (4, 'Pharmacist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 5) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (5, 'Lab Technician');
SET IDENTITY_INSERT [dbo].[Role] OFF;
PRINT 'Roles seeded.';
GO

-- ================================================================================
-- 2. DEPARTMENTS
-- ================================================================================
SET IDENTITY_INSERT [dbo].[department] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 1) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (1, 'Cardiology');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 2) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (2, 'Neurology');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 3) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (3, 'Orthopedics');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 4) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (4, 'Administration');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 5) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (5, 'Pharmacy');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 6) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (6, 'Laboratory');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 7) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (7, 'Reception');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 8) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (8, 'HR');
IF NOT EXISTS (SELECT 1 FROM [dbo].[department] WHERE [DepartmentId] = 9) INSERT INTO [dbo].[department] ([DepartmentId], [DepartmentName]) VALUES (9, 'General');
SET IDENTITY_INSERT [dbo].[department] OFF;
PRINT 'Departments seeded.';
GO

-- ================================================================================
-- 3. SPECIALIZATIONS
-- ================================================================================
SET IDENTITY_INSERT [dbo].[specialization] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 1) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (1, 'Cardiologist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 2) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (2, 'Neurologist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 3) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (3, 'Orthopedicsist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 4) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (4, 'General');
SET IDENTITY_INSERT [dbo].[specialization] OFF;
PRINT 'Specializations seeded.';
GO

-- ================================================================================
-- 4. WEEKDAYS
-- ================================================================================
SET IDENTITY_INSERT [dbo].[weekdays] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 1) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (1, 'Monday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 2) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (2, 'Tuesday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 3) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (3, 'Wednesday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 4) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (4, 'Thursday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 5) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (5, 'Friday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 6) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (6, 'Saturday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 7) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (7, 'Sunday');
SET IDENTITY_INSERT [dbo].[weekdays] OFF;
PRINT 'Weekdays seeded.';
GO

-- ================================================================================
-- 5. STATUS TABLES (NO IDENTITY)
-- ================================================================================
-- AppointmentStatus
IF NOT EXISTS (SELECT 1 FROM [dbo].[AppointmentStatus] WHERE [AppointmentStatusId] = 1)
    INSERT INTO [dbo].[AppointmentStatus] ([AppointmentStatusId], [AppointmentStatus]) VALUES (1, 'Success');
IF NOT EXISTS (SELECT 1 FROM [dbo].[AppointmentStatus] WHERE [AppointmentStatusId] = 2)
    INSERT INTO [dbo].[AppointmentStatus] ([AppointmentStatusId], [AppointmentStatus]) VALUES (2, 'Pending');

-- BillStatus
IF NOT EXISTS (SELECT 1 FROM [dbo].[BillStatus] WHERE [BillStatusId] = 1)
    INSERT INTO [dbo].[BillStatus] ([BillStatusId], [BillStatus]) VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[BillStatus] WHERE [BillStatusId] = 2)
    INSERT INTO [dbo].[BillStatus] ([BillStatusId], [BillStatus]) VALUES (2, 'Unpaid');

-- LabTestBillStatus
IF NOT EXISTS (SELECT 1 FROM [dbo].[LabTestBillStatus] WHERE [LabTestBillStatusId] = 1)
    INSERT INTO [dbo].[LabTestBillStatus] ([LabTestBillStatusId], [LabTestBillStatus]) VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[LabTestBillStatus] WHERE [LabTestBillStatusId] = 2)
    INSERT INTO [dbo].[LabTestBillStatus] ([LabTestBillStatusId], [LabTestBillStatus]) VALUES (2, 'Unpaid');

-- MedDistributionStatus
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedDistributionStatus] WHERE [MedStatusId] = 1)
    INSERT INTO [dbo].[MedDistributionStatus] ([MedStatusId], [MedStatusName]) VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedDistributionStatus] WHERE [MedStatusId] = 2)
    INSERT INTO [dbo].[MedDistributionStatus] ([MedStatusId], [MedStatusName]) VALUES (2, 'Unpaid');

-- MedicineBillStatus
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineBillStatus] WHERE [PaymentStatusId] = 1)
    INSERT INTO [dbo].[MedicineBillStatus] ([PaymentStatusId], [PaymentStatusName]) VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineBillStatus] WHERE [PaymentStatusId] = 2)
    INSERT INTO [dbo].[MedicineBillStatus] ([PaymentStatusId], [PaymentStatusName]) VALUES (2, 'Unpaid');

PRINT 'Status tables seeded.';
GO

-- ================================================================================
-- 6. MEDICINE CATEGORIES
-- ================================================================================
SET IDENTITY_INSERT [dbo].[Category] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE [CategoryId] = 1) INSERT INTO [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (1, N'Syrup');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE [CategoryId] = 2) INSERT INTO [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (2, N'Tablet');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE [CategoryId] = 3) INSERT INTO [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (3, N'Injection');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE [CategoryId] = 4) INSERT INTO [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (4, N'Capsule');
SET IDENTITY_INSERT [dbo].[Category] OFF;
PRINT 'Categories seeded.';
GO

-- ================================================================================
-- 7. LAB TESTS CATALOG
-- ================================================================================
SET IDENTITY_INSERT [dbo].[Labtest] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 1) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (1, 'Blood Test', 70.00, 100.00, 300.00, 'Blood', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 2) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (2, 'Urine Test', 5.00, 7.00, 200.00, 'Urine', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 3) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (3, 'Complete Blood Count', 4.00, 10.50, 300.00, 'Blood', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 4) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (4, 'Liver Function Test', 0.50, 5.00, 700.00, 'Blood', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 5) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (5, 'Thyroid Panel', 0.20, 4.50, 500.00, 'Blood', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 6) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (6, 'Lipid Profile', 100.00, 200.00, 800.00, 'Blood', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 7) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (7, 'Blood Glucose Test', 70.00, 110.00, 200.00, 'Blood', '2024-01-01');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 8) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample], [CreatedDate]) VALUES (8, 'Urine Routine Test', 5.00, 15.00, 150.00, 'Urine', '2024-01-01');
SET IDENTITY_INSERT [dbo].[Labtest] OFF;
PRINT 'Lab Tests seeded.';
GO

-- ================================================================================
-- 8. TIME SLOTS
-- ================================================================================
SET IDENTITY_INSERT [dbo].[timeslot] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 1) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (1, '13:00:00', '15:00:00', 7);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 2) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (2, '16:00:00', '18:00:00', 5);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 3) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (3, '19:00:00', '21:00:00', 6);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 4) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (4, '22:00:00', '23:59:59', 6);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 5) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (5, '09:00:00', '11:00:00', 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 6) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (6, '11:00:00', '14:00:00', 4);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 7) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (7, '17:00:00', '19:00:00', 4);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 8) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (8, '01:00:00', '03:00:00', 3);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 9) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (9, '03:00:00', '06:00:00', 2);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 10) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (10, '07:00:00', '11:00:00', 1);
SET IDENTITY_INSERT [dbo].[timeslot] OFF;
PRINT 'Timeslots seeded.';
GO

-- ================================================================================
-- 9. MEDICINES CATALOG & INVENTORY
-- ================================================================================
SET IDENTITY_INSERT [dbo].[MedicineDetails] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineDetails] WHERE [MedicineId] = 1)
    INSERT INTO [dbo].[MedicineDetails] ([MedicineId], [MedicineName], [Cost], [ManufacturingDate], [ExpiryDate], [CategoryId], [IsActive])
    VALUES (1, N'Paracetamol 500mg', 30.00, '2024-01-01', '2026-01-01', 2, 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineDetails] WHERE [MedicineId] = 2)
    INSERT INTO [dbo].[MedicineDetails] ([MedicineId], [MedicineName], [Cost], [ManufacturingDate], [ExpiryDate], [CategoryId], [IsActive])
    VALUES (2, N'Dolo 650', 120.00, '2024-01-05', '2025-11-08', 2, 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineDetails] WHERE [MedicineId] = 3)
    INSERT INTO [dbo].[MedicineDetails] ([MedicineId], [MedicineName], [Cost], [ManufacturingDate], [ExpiryDate], [CategoryId], [IsActive])
    VALUES (3, N'Amoxicillin 250mg Syrup', 85.00, '2024-02-15', '2025-08-15', 1, 1);
SET IDENTITY_INSERT [dbo].[MedicineDetails] OFF;

-- Medicine Inventory
SET IDENTITY_INSERT [dbo].[MedicineInventory] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineInventory] WHERE [MedicineStockId] = 1)
    INSERT INTO [dbo].[MedicineInventory] ([MedicineStockId], [MedicineId], [StockInHand], [ReOrderLevel], [Purchase], [Issuance], [IsActive])
    VALUES (1, 1, 500, 50, 500, 0, 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineInventory] WHERE [MedicineStockId] = 2)
    INSERT INTO [dbo].[MedicineInventory] ([MedicineStockId], [MedicineId], [StockInHand], [ReOrderLevel], [Purchase], [Issuance], [IsActive])
    VALUES (2, 2, 350, 30, 400, 50, 1);
SET IDENTITY_INSERT [dbo].[MedicineInventory] OFF;
PRINT 'Medicines & Inventory seeded.';
GO

-- ================================================================================
-- 10. STAFF PROFILES
-- ================================================================================
SET IDENTITY_INSERT [dbo].[staff] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 100)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (100, 'Thanya', '2002-09-10', 'Female', 4, '9487507918', 'thanya@gmail.com', '2024-03-10', 88000.00, 'Admin Block');

IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 101)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (101, 'Thomas', '1998-06-09', 'Male', 2, '8790888902', 'thomas@gmail.com', '2024-01-15', 100000.00, 'Medical Staff Quarters');

IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 105)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (105, 'James', '2002-12-04', 'Male', 4, '9778687902', 'james@gmail.com', '2024-02-01', 40000.00, 'City Center');

IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 106)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (106, 'Tharak', '2000-01-25', 'Male', 5, '7890987678', 'tharak@gmail.com', '2024-01-20', 45000.00, 'Pharmacy Wing');

IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 107)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (107, 'Karthika', '2002-12-17', 'Female', 6, '7890333333', 'karthika@gmail.com', '2024-01-20', 67000.00, 'Diagnostics Wing');

IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 108)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (108, 'Ahal', '2002-12-18', 'Female', 7, '8908765432', 'aha@gmail.com', '2024-02-10', 80000.00, 'Reception Desk');

IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 109)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [DOJ], [Salary], [Address])
    VALUES (109, 'Varsha', '2002-12-07', 'Female', 2, '8909999999', 'varsha@gmail.com', '2024-03-01', 90000.00, 'Doctors Wing');
SET IDENTITY_INSERT [dbo].[staff] OFF;
PRINT 'Staff seeded.';
GO

-- ================================================================================
-- 11. LOGIN CREDENTIALS
-- ================================================================================
SET IDENTITY_INSERT [dbo].[LoginRegistration] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 3)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (3, 'thanya', '10041', 1, 100, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 4)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (4, 'thomas', 'thomas123', 2, 101, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 5)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (5, 'james', 'james123', 1, 105, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 6)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (6, 'varsha', '111', 2, 109, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 7)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (7, 'ahal', '111', 3, 108, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 8)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (8, 'tharak', '111', 4, 106, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 9)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (9, 'karthika', '111', 5, 107, 1);
SET IDENTITY_INSERT [dbo].[LoginRegistration] OFF;
PRINT 'Login registrations seeded.';
GO

-- ================================================================================
-- 12. DOCTORS & AVAILABILITY
-- ================================================================================
SET IDENTITY_INSERT [dbo].[doctor] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[doctor] WHERE [DoctorId] = 1)
    INSERT INTO [dbo].[doctor] ([DoctorId], [RegistrationId], [SpecializationId], [ConsultationFee], [DoctorIsActive])
    VALUES (1, 4, 1, 300.00, 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[doctor] WHERE [DoctorId] = 2)
    INSERT INTO [dbo].[doctor] ([DoctorId], [RegistrationId], [SpecializationId], [ConsultationFee], [DoctorIsActive])
    VALUES (2, 6, 2, 400.00, 1);
SET IDENTITY_INSERT [dbo].[doctor] OFF;

-- Availability
SET IDENTITY_INSERT [dbo].[availability] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[availability] WHERE [AvailabilityId] = 1)
    INSERT INTO [dbo].[availability] ([AvailabilityId], [DoctorId], [TimeSlotId], [Session])
    VALUES (1, 1, 4, 'Evening');

IF NOT EXISTS (SELECT 1 FROM [dbo].[availability] WHERE [AvailabilityId] = 2)
    INSERT INTO [dbo].[availability] ([AvailabilityId], [DoctorId], [TimeSlotId], [Session])
    VALUES (2, 2, 3, 'Evening');
SET IDENTITY_INSERT [dbo].[availability] OFF;
PRINT 'Doctors & Availability seeded.';
GO

-- ================================================================================
-- 13. PATIENTS (SAMPLE DATA)
-- ================================================================================
SET IDENTITY_INSERT [dbo].[Patient] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Patient] WHERE [PatientId] = 1)
    INSERT INTO [dbo].[Patient] ([PatientId], [PatientName], [DOB], [Gender], [BloodGroup], [PatientPhone], [PatientAddress], [RegistrationDate], [IsActive])
    VALUES (1, 'Mathews', '2000-01-17', 'M', 'O+', '7834221231', 'Kannyakumari', '2025-01-25 08:06:44.377', 1);

IF NOT EXISTS (SELECT 1 FROM [dbo].[Patient] WHERE [PatientId] = 2)
    INSERT INTO [dbo].[Patient] ([PatientId], [PatientName], [DOB], [Gender], [BloodGroup], [PatientPhone], [PatientAddress], [RegistrationDate], [IsActive])
    VALUES (2, 'Hannah', '2001-05-12', 'F', 'A-', '8989898090', 'Trivandrum', '2025-01-25 08:41:45.197', 1);
SET IDENTITY_INSERT [dbo].[Patient] OFF;
PRINT 'Patients seeded.';
GO

PRINT '================================================================================';
PRINT 'All Seed Data Inserted Successfully for ClinicManagementSys.';
PRINT '================================================================================';
GO
