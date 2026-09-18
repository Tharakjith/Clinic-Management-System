/*
================================================================================
   CLINIC MANAGEMENT SYSTEM (CMS) - MASTER DATABASE DEPLOYMENT SCRIPT
   File: 00_MASTER_CMS_DATABASE.sql
   Target Engine: Microsoft SQL Server (2019 / 2022 / Azure SQL)
   Version: 1.0 Enterprise
   
   Contents:
     Part 1: Database Creation
     Part 2: 29 Relational Tables (PKs, FKs, Defaults, Computed Columns)
     Part 3: Master & Seed Data (Roles, Departments, Staff, Doctors, Logins, etc.)
     Part 4: Stored Procedures (Authentication, Booking, Labs, Dispensing, Billing)
     Part 5: Views & User-Defined Functions
================================================================================
*/

-- ================================================================================
-- PART 1: DATABASE INITIALIZATION
-- ================================================================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ClinicManagementSys')
BEGIN
    CREATE DATABASE [ClinicManagementSys];
    PRINT '>> Database [ClinicManagementSys] created.';
END
ELSE
BEGIN
    PRINT '>> Database [ClinicManagementSys] already exists.';
END
GO

USE [ClinicManagementSys];
GO

-- ================================================================================
-- PART 2: DDL - TABLES CREATION (29 TABLES IN DEPENDENCY ORDER)
-- ================================================================================

-- 1. Role
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Role')
BEGIN
    CREATE TABLE [dbo].[Role] (
        [RoleId]   INT IDENTITY(1,1) NOT NULL,
        [RoleName] VARCHAR(15) NULL,
        CONSTRAINT [PK__Role__8AFACE1A31305CBA] PRIMARY KEY CLUSTERED ([RoleId] ASC)
    );
END
GO

-- 2. department
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'department')
BEGIN
    CREATE TABLE [dbo].[department] (
        [DepartmentId]   INT IDENTITY(1,1) NOT NULL,
        [DepartmentName] VARCHAR(20) NULL,
        CONSTRAINT [PK__departme__B2079BEDDEC53583] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
    );
END
GO

-- 3. specialization
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'specialization')
BEGIN
    CREATE TABLE [dbo].[specialization] (
        [SpecializationId]   INT IDENTITY(1,1) NOT NULL,
        [SpecializationName] VARCHAR(30) NULL,
        CONSTRAINT [PK__speciali__5809D86F5BE2A555] PRIMARY KEY CLUSTERED ([SpecializationId] ASC)
    );
END
GO

-- 4. weekdays
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'weekdays')
BEGIN
    CREATE TABLE [dbo].[weekdays] (
        [WeekdaysId]   INT IDENTITY(1,1) NOT NULL,
        [WeekdaysName] VARCHAR(10) NULL,
        CONSTRAINT [PK__weekdays__D053E4AF0183A13F] PRIMARY KEY CLUSTERED ([WeekdaysId] ASC)
    );
END
GO

-- 5. AppointmentStatus
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'AppointmentStatus')
BEGIN
    CREATE TABLE [dbo].[AppointmentStatus] (
        [AppointmentStatusId] INT NOT NULL,
        [AppointmentStatus]   VARCHAR(20) NULL,
        CONSTRAINT [PK__Appointm__A619B660C61691C6] PRIMARY KEY CLUSTERED ([AppointmentStatusId] ASC),
        CONSTRAINT [UQ__Appointm__BABC696605623C0C] UNIQUE NONCLUSTERED ([AppointmentStatus] ASC)
    );
END
GO

-- 6. BillStatus
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'BillStatus')
BEGIN
    CREATE TABLE [dbo].[BillStatus] (
        [BillStatusId] INT NOT NULL,
        [BillStatus]   VARCHAR(20) NULL,
        CONSTRAINT [PK__BillStat__C3D12851881A8593] PRIMARY KEY CLUSTERED ([BillStatusId] ASC),
        CONSTRAINT [UQ__BillStat__662BD8AEFBCAAA39] UNIQUE NONCLUSTERED ([BillStatus] ASC)
    );
END
GO

-- 7. Category
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Category')
BEGIN
    CREATE TABLE [dbo].[Category] (
        [CategoryId]   INT IDENTITY(1,1) NOT NULL,
        [CategoryName] NVARCHAR(50) NULL,
        CONSTRAINT [PK__Category__19093A0BA1E1AFB3] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
    );
END
GO

-- 8. LabTestBillStatus
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LabTestBillStatus')
BEGIN
    CREATE TABLE [dbo].[LabTestBillStatus] (
        [LabTestBillStatusId] INT NOT NULL,
        [LabTestBillStatus]   VARCHAR(20) NULL,
        CONSTRAINT [PK__LabTestB__224C5B0E5B1E91A1] PRIMARY KEY CLUSTERED ([LabTestBillStatusId] ASC),
        CONSTRAINT [UQ__LabTestB__15FEC2E2642FE6EA] UNIQUE NONCLUSTERED ([LabTestBillStatus] ASC)
    );
END
GO

-- 9. MedDistributionStatus
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedDistributionStatus')
BEGIN
    CREATE TABLE [dbo].[MedDistributionStatus] (
        [MedStatusId]   INT NOT NULL,
        [MedStatusName] VARCHAR(20) NULL,
        CONSTRAINT [PK__MedDistr__1DC2948723C48B90] PRIMARY KEY CLUSTERED ([MedStatusId] ASC),
        CONSTRAINT [UQ__MedDistr__F3A409D9B9E0B6A5] UNIQUE NONCLUSTERED ([MedStatusName] ASC)
    );
END
GO

-- 10. MedicineBillStatus
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedicineBillStatus')
BEGIN
    CREATE TABLE [dbo].[MedicineBillStatus] (
        [PaymentStatusId]   INT NOT NULL,
        [PaymentStatusName] VARCHAR(20) NULL,
        CONSTRAINT [PK__Medicine__34F8AC3FC2A7B38F] PRIMARY KEY CLUSTERED ([PaymentStatusId] ASC),
        CONSTRAINT [UQ__Medicine__BBAC58DB9D7DD3A6] UNIQUE NONCLUSTERED ([PaymentStatusName] ASC)
    );
END
GO

-- 11. Labtest
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Labtest')
BEGIN
    CREATE TABLE [dbo].[Labtest] (
        [LabTestId]   INT IDENTITY(1,1) NOT NULL,
        [TestName]    VARCHAR(30) NULL,
        [LowRange]    DECIMAL(10, 2) NULL,
        [HighRange]   DECIMAL(10, 2) NULL,
        [Price]       DECIMAL(10, 2) NULL,
        [Sample]      VARCHAR(15) NULL,
        [CreatedDate] DATE NULL DEFAULT (sysdatetime()),
        CONSTRAINT [PK__Labtest__64D339258279E5AD] PRIMARY KEY CLUSTERED ([LabTestId] ASC)
    );
END
GO

-- 12. Patient
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Patient')
BEGIN
    CREATE TABLE [dbo].[Patient] (
        [PatientId]        INT IDENTITY(1,1) NOT NULL,
        [PatientName]      VARCHAR(50) NULL,
        [DOB]              DATE NULL,
        [Gender]           CHAR(1) NULL,
        [BloodGroup]       VARCHAR(5) NULL,
        [PatientPhone]     VARCHAR(10) NULL,
        [PatientAddress]   VARCHAR(250) NULL,
        [RegistrationDate] DATETIME NULL DEFAULT (getdate()),
        [IsActive]         BIT NOT NULL DEFAULT ((1)),
        CONSTRAINT [PK__Patient__970EC3669A7F5939] PRIMARY KEY CLUSTERED ([PatientId] ASC)
    );
END
GO

-- 13. staff
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'staff')
BEGIN
    CREATE TABLE [dbo].[staff] (
        [StaffId]      INT IDENTITY(100,1) NOT NULL,
        [StaffName]    VARCHAR(20) NULL,
        [DOB]          DATE NULL,
        [Gender]       VARCHAR(10) NULL,
        [DepartmentId] INT NULL,
        [PhoneNumber]  VARCHAR(10) NULL,
        [Email]        VARCHAR(20) NULL,
        [DOJ]          DATE NULL,
        [Salary]       DECIMAL(10, 2) NULL,
        [Address]      VARCHAR(30) NULL,
        [CreatedDate]  DATE NULL DEFAULT (sysdatetime()),
        CONSTRAINT [PK__staff__96D4AB17D3C83623] PRIMARY KEY CLUSTERED ([StaffId] ASC),
        CONSTRAINT [FK__staff__Departmen__3B75D760] FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[department] ([DepartmentId])
    );
END
GO

-- 14. timeslot
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'timeslot')
BEGIN
    CREATE TABLE [dbo].[timeslot] (
        [TimeSlotId] INT IDENTITY(1,1) NOT NULL,
        [StartTime]  TIME NULL,
        [EndTime]    TIME NULL,
        [WeekdaysId] INT NULL,
        CONSTRAINT [PK__timeslot__41CC1F32E20FF162] PRIMARY KEY CLUSTERED ([TimeSlotId] ASC),
        CONSTRAINT [FK__timeslot__Weekda__4BAC3F29] FOREIGN KEY ([WeekdaysId]) REFERENCES [dbo].[weekdays] ([WeekdaysId])
    );
END
GO

-- 15. MedicineDetails
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedicineDetails')
BEGIN
    CREATE TABLE [dbo].[MedicineDetails] (
        [MedicineId]        INT IDENTITY(1,1) NOT NULL,
        [MedicineName]      NVARCHAR(100) NOT NULL,
        [Cost]              DECIMAL(18, 2) NOT NULL,
        [ManufacturingDate] DATE NOT NULL,
        [ExpiryDate]        DATE NOT NULL,
        [CategoryId]        INT NOT NULL,
        [IsActive]          BIT NOT NULL DEFAULT ((1)),
        CONSTRAINT [PK__Medicine__4F212890FC081A60] PRIMARY KEY CLUSTERED ([MedicineId] ASC),
        CONSTRAINT [FK__MedicineD__Categ__00200768] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Category] ([CategoryId])
    );
END
GO

-- 16. LoginRegistration
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LoginRegistration')
BEGIN
    CREATE TABLE [dbo].[LoginRegistration] (
        [RegistrationId] INT IDENTITY(1,1) NOT NULL,
        [Username]       VARCHAR(20) NULL,
        [Password]       VARCHAR(128) NOT NULL,
        [RoleId]         INT NULL,
        [StaffId]        INT NULL,
        [RegisteredDate] DATE NULL DEFAULT (sysdatetime()),
        [RIsActive]      BIT NULL,
        CONSTRAINT [PK__LoginReg__6EF588108FF342C1] PRIMARY KEY CLUSTERED ([RegistrationId] ASC),
        CONSTRAINT [UQ__LoginReg__536C85E4F0D0CB71] UNIQUE NONCLUSTERED ([Username] ASC),
        CONSTRAINT [FK__LoginRegi__RoleI__403A8C7D] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]),
        CONSTRAINT [FK__LoginRegi__Staff__3F466844] FOREIGN KEY ([StaffId]) REFERENCES [dbo].[staff] ([StaffId])
    );
END
GO

-- 17. MedicineInventory
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedicineInventory')
BEGIN
    CREATE TABLE [dbo].[MedicineInventory] (
        [MedicineStockId] INT IDENTITY(1,1) NOT NULL,
        [MedicineId]      INT NULL,
        [StockInHand]     INT NULL,
        [ReOrderLevel]    INT NULL,
        [Purchase]        INT NULL,
        [Issuance]        INT NULL,
        [IsActive]        BIT NULL,
        CONSTRAINT [PK__Medicine__FA952718DAA940CE] PRIMARY KEY CLUSTERED ([MedicineStockId] ASC),
        CONSTRAINT [FK__MedicineI__Medic__06CD04F7] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[MedicineDetails] ([MedicineId])
    );
END
GO

-- 18. doctor
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'doctor')
BEGIN
    CREATE TABLE [dbo].[doctor] (
        [DoctorId]         INT IDENTITY(1,1) NOT NULL,
        [RegistrationId]   INT NULL,
        [SpecializationId] INT NULL,
        [ConsultationFee]  DECIMAL(10, 2) NULL,
        [DoctorIsActive]   BIT NULL,
        CONSTRAINT [PK__doctor__2DC00EBF38AB7920] PRIMARY KEY CLUSTERED ([DoctorId] ASC),
        CONSTRAINT [FK__doctor__Registra__46E78A0C] FOREIGN KEY ([RegistrationId]) REFERENCES [dbo].[LoginRegistration] ([RegistrationId]),
        CONSTRAINT [FK__doctor__Speciali__45F365D3] FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[specialization] ([SpecializationId])
    );
END
GO

-- 19. availability
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'availability')
BEGIN
    CREATE TABLE [dbo].[availability] (
        [AvailabilityId] INT IDENTITY(1,1) NOT NULL,
        [DoctorId]       INT NULL,
        [TimeSlotId]     INT NULL,
        [Session]        VARCHAR(10) NULL,
        CONSTRAINT [PK__availabi__DA3979B1C4452024] PRIMARY KEY CLUSTERED ([AvailabilityId] ASC),
        CONSTRAINT [FK__availabil__Docto__4E88ABD4] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[doctor] ([DoctorId]),
        CONSTRAINT [FK__availabil__TimeS__4F7CD00D] FOREIGN KEY ([TimeSlotId]) REFERENCES [dbo].[timeslot] ([TimeSlotId])
    );
END
GO

-- 20. Appointment
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Appointment')
BEGIN
    CREATE TABLE [dbo].[Appointment] (
        [AppointmentId]       INT IDENTITY(1,1) NOT NULL,
        [PatientId]           INT NOT NULL,
        [DoctorId]            INT NOT NULL,
        [SpecializationId]    INT NOT NULL,
        [AppointmentDate]     DATE NOT NULL,
        [AvailabilityId]      INT NOT NULL,
        [AppointmentStatusId] INT NOT NULL,
        [TokenNumber]         INT NULL,
        [RegistrationFee]     DECIMAL(10, 2) NULL DEFAULT ((150.00)),
        [ConsultationFee]     DECIMAL(10, 2) NULL,
        CONSTRAINT [PK__Appointm__8ECDFCC2AEE468B1] PRIMARY KEY CLUSTERED ([AppointmentId] ASC),
        CONSTRAINT [UQ__Appointm__435734E1FD4D00A8] UNIQUE NONCLUSTERED ([TokenNumber] ASC),
        CONSTRAINT [FK__Appointme__Patie__60A75C0F] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([PatientId]),
        CONSTRAINT [FK__Appointme__Speci__619B8048] FOREIGN KEY ([SpecializationId]) REFERENCES [dbo].[specialization] ([SpecializationId]),
        CONSTRAINT [FK__Appointme__Docto__628FA481] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[doctor] ([DoctorId]),
        CONSTRAINT [FK__Appointme__Avail__6383C8BA] FOREIGN KEY ([AvailabilityId]) REFERENCES [dbo].[availability] ([AvailabilityId]),
        CONSTRAINT [FK__Appointme__Appoi__656C112C] FOREIGN KEY ([AppointmentStatusId]) REFERENCES [dbo].[AppointmentStatus] ([AppointmentStatusId])
    );
END
GO

-- 21. DailyAvailability
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DailyAvailability')
BEGIN
    CREATE TABLE [dbo].[DailyAvailability] (
        [DailyAvailabilityId] INT IDENTITY(1,1) NOT NULL,
        [AppointmentId]       INT NOT NULL,
        [AvailabilityId]      INT NOT NULL,
        [IsAvailable]         BIT NOT NULL DEFAULT ((1)),
        CONSTRAINT [PK__DailyAva__C0E8C4C5E8C36817] PRIMARY KEY CLUSTERED ([DailyAvailabilityId] ASC),
        CONSTRAINT [FK__DailyAvai__Appoi__693CA210] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId]),
        CONSTRAINT [FK__DailyAvai__Avail__68487DD7] FOREIGN KEY ([AvailabilityId]) REFERENCES [dbo].[availability] ([AvailabilityId])
    );
END
GO

-- 22. PatientBill
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'PatientBill')
BEGIN
    CREATE TABLE [dbo].[PatientBill] (
        [PatientBillId]   INT IDENTITY(1,1) NOT NULL,
        [AppointmentId]   INT NOT NULL,
        [AppointmentDate] DATE NULL,
        [ConsultationFee] DECIMAL(10, 2) NULL,
        [RegistrationFee] DECIMAL(10, 2) NULL,
        [TotalFee]        AS ([ConsultationFee] + [RegistrationFee]) PERSISTED,
        [BillStatusId]    INT NOT NULL,
        CONSTRAINT [PK__PatientB__B73F3B21FF729F22] PRIMARY KEY CLUSTERED ([PatientBillId] ASC),
        CONSTRAINT [FK__PatientBi__Appoi__6FE99F9F] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId]),
        CONSTRAINT [FK__PatientBi__BillS__70DDC3D8] FOREIGN KEY ([BillStatusId]) REFERENCES [dbo].[BillStatus] ([BillStatusId])
    );
END
GO

-- 23. StartDiagnosys
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'StartDiagnosys')
BEGIN
    CREATE TABLE [dbo].[StartDiagnosys] (
        [HistoryId]     INT IDENTITY(1,1) NOT NULL,
        [Diagnosis]     VARCHAR(50) NULL,
        [Symptoms]      VARCHAR(50) NULL,
        [NextVisiting]  DATETIME NULL,
        [DoctorNote]    VARCHAR(100) NULL,
        [DiagnosysDate] DATETIME NULL,
        [Reference]     INT NULL,
        [AppointmentId] INT NULL,
        CONSTRAINT [PK__StartDia__4D7B4ABDF01911F4] PRIMARY KEY CLUSTERED ([HistoryId] ASC),
        CONSTRAINT [FK__StartDiag__Refer__73BA3083] FOREIGN KEY ([Reference]) REFERENCES [dbo].[StartDiagnosys] ([HistoryId]),
        CONSTRAINT [FK__StartDiag__Appoi__74AE54BC] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId])
    );
END
GO

-- 24. Prescription
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Prescription')
BEGIN
    CREATE TABLE [dbo].[Prescription] (
        [PrescriptionId] INT IDENTITY(1,1) NOT NULL,
        [AppointmentId]  INT NULL,
        [MedicineId]     INT NULL,
        [Dosage]         VARCHAR(20) NOT NULL,
        [Frequency]      VARCHAR(50) NOT NULL,
        [NumberofDays]   INT NULL,
        CONSTRAINT [PK__Prescrip__40130832F3275E41] PRIMARY KEY CLUSTERED ([PrescriptionId] ASC),
        CONSTRAINT [FK__Prescript__Appoi__02FC7413] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId]),
        CONSTRAINT [FK__Prescript__Medic__03F0984C] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[MedicineDetails] ([MedicineId])
    );
END
GO

-- 25. TestPrescription
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TestPrescription')
BEGIN
    CREATE TABLE [dbo].[TestPrescription] (
        [TP_Id]         INT IDENTITY(1,1) NOT NULL,
        [AppointmentId] INT NULL,
        [LabTestId]     INT NULL,
        [SampleItem]    VARCHAR(20) NULL,
        CONSTRAINT [PK__TestPres__8106F224436BB589] PRIMARY KEY CLUSTERED ([TP_Id] ASC),
        CONSTRAINT [FK__TestPresc__Appoi__778AC167] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId]),
        CONSTRAINT [FK__TestPresc__LabTe__787EE5A0] FOREIGN KEY ([LabTestId]) REFERENCES [dbo].[Labtest] ([LabTestId])
    );
END
GO

-- 26. MedicineDistribution
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedicineDistribution')
BEGIN
    CREATE TABLE [dbo].[MedicineDistribution] (
        [MedDistId]           INT IDENTITY(1,1) NOT NULL,
        [PrescriptionId]      INT NULL,
        [MedicineId]          INT NULL,
        [QuantityDistributed] INT NOT NULL,
        [MedStatusId]         INT NULL,
        [DistributionDate]    DATETIME NULL DEFAULT (getdate()),
        CONSTRAINT [PK__Medicine__BC4B56A9994362F1] PRIMARY KEY CLUSTERED ([MedDistId] ASC),
        CONSTRAINT [FK__MedicineD__Presc__17F790F9] FOREIGN KEY ([PrescriptionId]) REFERENCES [dbo].[Prescription] ([PrescriptionId]),
        CONSTRAINT [FK__MedicineD__Medic__18EBB532] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[MedicineDetails] ([MedicineId]),
        CONSTRAINT [FK__MedicineD__MedSt__1AD3FDA4] FOREIGN KEY ([MedStatusId]) REFERENCES [dbo].[MedDistributionStatus] ([MedStatusId])
    );
END
GO

-- 27. LabTestReport
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LabTestReport')
BEGIN
    CREATE TABLE [dbo].[LabTestReport] (
        [LTReportId]    INT IDENTITY(1,1) NOT NULL,
        [AppointmentId] INT NOT NULL,
        [LabTestId]     INT NOT NULL,
        [HighRange]     INT NULL,
        [LowRange]      INT NULL,
        [ActualResult]  INT NULL,
        [Remarks]       VARCHAR(250) NULL,
        CONSTRAINT [PK__LabTestR__BF47B0530D669335] PRIMARY KEY CLUSTERED ([LTReportId] ASC),
        CONSTRAINT [FK__LabTestRe__Appoi__236943A5] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId]),
        CONSTRAINT [FK__LabTestRe__LabTe__245D67DE] FOREIGN KEY ([LabTestId]) REFERENCES [dbo].[Labtest] ([LabTestId])
    );
END
GO

-- 28. MedicineBill
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedicineBill')
BEGIN
    CREATE TABLE [dbo].[MedicineBill] (
        [MedicineBillId]  INT IDENTITY(1,1) NOT NULL,
        [MedDistId]       INT NULL,
        [DoctorId]        INT NULL,
        [PatientId]       INT NULL,
        [TotalAmount]     DECIMAL(10, 2) NOT NULL,
        [PaymentStatusId] INT NULL,
        [PaymentDate]     DATETIME NULL,
        [Remarks]         VARCHAR(255) NULL,
        CONSTRAINT [PK__Medicine__EF3B0260B222AF7C] PRIMARY KEY CLUSTERED ([MedicineBillId] ASC),
        CONSTRAINT [FK__MedicineB__MedDi__1DB06A4F] FOREIGN KEY ([MedDistId]) REFERENCES [dbo].[MedicineDistribution] ([MedDistId]),
        CONSTRAINT [FK__MedicineB__Docto__1EA48E88] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[doctor] ([DoctorId]),
        CONSTRAINT [FK__MedicineB__Patie__1F98B2C1] FOREIGN KEY ([PatientId]) REFERENCES [dbo].[Patient] ([PatientId]),
        CONSTRAINT [FK__MedicineB__Payme__208CD6FA] FOREIGN KEY ([PaymentStatusId]) REFERENCES [dbo].[MedicineBillStatus] ([PaymentStatusId])
    );
END
GO

-- 29. LabTestBill
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LabTestBill')
BEGIN
    CREATE TABLE [dbo].[LabTestBill] (
        [LabTestBillId]       INT IDENTITY(1,1) NOT NULL,
        [LTReportId]          INT NOT NULL,
        [TestPrice]           DECIMAL(10, 2) NULL,
        [TestDate]            DATETIME NULL DEFAULT (getdate()),
        [PaymentDate]         DATETIME NULL,
        [LabTestBillStatusId] INT NULL,
        CONSTRAINT [PK__LabTestB__2DECF1FDCCB6F2E2] PRIMARY KEY CLUSTERED ([LabTestBillId] ASC),
        CONSTRAINT [FK__LabTestBi__LTRep__2EDAF651] FOREIGN KEY ([LTReportId]) REFERENCES [dbo].[LabTestReport] ([LTReportId]),
        CONSTRAINT [FK__LabTestBi__LabTe__30C33EC3] FOREIGN KEY ([LabTestBillStatusId]) REFERENCES [dbo].[LabTestBillStatus] ([LabTestBillStatusId])
    );
END
GO
PRINT '>> All 29 tables verified/created.';
GO

-- ================================================================================
-- PART 3: MASTER & SEED DATA
-- ================================================================================

-- Roles
SET IDENTITY_INSERT [dbo].[Role] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 1) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, 'Admin');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 2) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, 'Doctor');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 3) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, 'Receptionist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 4) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (4, 'Pharmacist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Role] WHERE [RoleId] = 5) INSERT INTO [dbo].[Role] ([RoleId], [RoleName]) VALUES (5, 'Lab Technician');
SET IDENTITY_INSERT [dbo].[Role] OFF;

-- Departments
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

-- Specializations
SET IDENTITY_INSERT [dbo].[specialization] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 1) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (1, 'Cardiologist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 2) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (2, 'Neurologist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 3) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (3, 'Orthopedicsist');
IF NOT EXISTS (SELECT 1 FROM [dbo].[specialization] WHERE [SpecializationId] = 4) INSERT INTO [dbo].[specialization] ([SpecializationId], [SpecializationName]) VALUES (4, 'General');
SET IDENTITY_INSERT [dbo].[specialization] OFF;

-- Weekdays
SET IDENTITY_INSERT [dbo].[weekdays] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 1) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (1, 'Monday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 2) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (2, 'Tuesday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 3) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (3, 'Wednesday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 4) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (4, 'Thursday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 5) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (5, 'Friday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 6) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (6, 'Saturday');
IF NOT EXISTS (SELECT 1 FROM [dbo].[weekdays] WHERE [WeekdaysId] = 7) INSERT INTO [dbo].[weekdays] ([WeekdaysId], [WeekdaysName]) VALUES (7, 'Sunday');
SET IDENTITY_INSERT [dbo].[weekdays] OFF;

-- Statuses
IF NOT EXISTS (SELECT 1 FROM [dbo].[AppointmentStatus] WHERE [AppointmentStatusId] = 1) INSERT INTO [dbo].[AppointmentStatus] VALUES (1, 'Success');
IF NOT EXISTS (SELECT 1 FROM [dbo].[AppointmentStatus] WHERE [AppointmentStatusId] = 2) INSERT INTO [dbo].[AppointmentStatus] VALUES (2, 'Pending');
IF NOT EXISTS (SELECT 1 FROM [dbo].[BillStatus] WHERE [BillStatusId] = 1) INSERT INTO [dbo].[BillStatus] VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[BillStatus] WHERE [BillStatusId] = 2) INSERT INTO [dbo].[BillStatus] VALUES (2, 'Unpaid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[LabTestBillStatus] WHERE [LabTestBillStatusId] = 1) INSERT INTO [dbo].[LabTestBillStatus] VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[LabTestBillStatus] WHERE [LabTestBillStatusId] = 2) INSERT INTO [dbo].[LabTestBillStatus] VALUES (2, 'Unpaid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedDistributionStatus] WHERE [MedStatusId] = 1) INSERT INTO [dbo].[MedDistributionStatus] VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedDistributionStatus] WHERE [MedStatusId] = 2) INSERT INTO [dbo].[MedDistributionStatus] VALUES (2, 'Unpaid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineBillStatus] WHERE [PaymentStatusId] = 1) INSERT INTO [dbo].[MedicineBillStatus] VALUES (1, 'Paid');
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineBillStatus] WHERE [PaymentStatusId] = 2) INSERT INTO [dbo].[MedicineBillStatus] VALUES (2, 'Unpaid');

-- Categories
SET IDENTITY_INSERT [dbo].[Category] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE [CategoryId] = 1) INSERT INTO [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (1, N'Syrup');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE [CategoryId] = 2) INSERT INTO [dbo].[Category] ([CategoryId], [CategoryName]) VALUES (2, N'Tablet');
SET IDENTITY_INSERT [dbo].[Category] OFF;

-- Lab Tests Catalog
SET IDENTITY_INSERT [dbo].[Labtest] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 1) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (1, 'Blood Test', 70.00, 100.00, 300.00, 'Blood');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 2) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (2, 'Urine Test', 5.00, 7.00, 200.00, 'Urine');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 3) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (3, 'Complete Blood Count', 4.00, 10.50, 300.00, 'Blood');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 4) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (4, 'Liver Function Test', 0.50, 5.00, 700.00, 'Blood');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 5) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (5, 'Thyroid Panel', 0.20, 4.50, 500.00, 'Blood');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 6) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (6, 'Lipid Profile', 100.00, 200.00, 800.00, 'Blood');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 7) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (7, 'Blood Glucose Test', 70.00, 110.00, 200.00, 'Blood');
IF NOT EXISTS (SELECT 1 FROM [dbo].[Labtest] WHERE [LabTestId] = 8) INSERT INTO [dbo].[Labtest] ([LabTestId], [TestName], [LowRange], [HighRange], [Price], [Sample]) VALUES (8, 'Urine Routine Test', 5.00, 15.00, 150.00, 'Urine');
SET IDENTITY_INSERT [dbo].[Labtest] OFF;

-- Time Slots
SET IDENTITY_INSERT [dbo].[timeslot] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 1) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (1, '13:00:00', '15:00:00', 7);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 2) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (2, '16:00:00', '18:00:00', 5);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 3) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (3, '19:00:00', '21:00:00', 6);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 4) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (4, '22:00:00', '23:59:59', 6);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 5) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (5, '09:00:00', '11:00:00', 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 6) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (6, '11:00:00', '14:00:00', 4);
IF NOT EXISTS (SELECT 1 FROM [dbo].[timeslot] WHERE [TimeSlotId] = 7) INSERT INTO [dbo].[timeslot] ([TimeSlotId], [StartTime], [EndTime], [WeekdaysId]) VALUES (7, '17:00:00', '19:00:00', 4);
SET IDENTITY_INSERT [dbo].[timeslot] OFF;

-- Staff
SET IDENTITY_INSERT [dbo].[staff] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 100)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [Salary])
    VALUES (100, 'Thanya', '2002-09-10', 'Female', 4, '9487507918', 'thanya@gmail.com', 88000.00);
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 101)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [Salary])
    VALUES (101, 'Thomas', '1998-06-09', 'Male', 2, '8790888902', 'thomas@gmail.com', 100000.00);
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 106)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [Salary])
    VALUES (106, 'Tharak', '2000-01-25', 'Male', 5, '7890987678', 'tharak@gmail.com', 45000.00);
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 107)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [Salary])
    VALUES (107, 'Karthika', '2002-12-17', 'Female', 6, '7890333333', 'karthika@gmail.com', 67000.00);
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 108)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [Salary])
    VALUES (108, 'Ahal', '2002-12-18', 'Female', 7, '8908765432', 'aha@gmail.com', 80000.00);
IF NOT EXISTS (SELECT 1 FROM [dbo].[staff] WHERE [StaffId] = 109)
    INSERT INTO [dbo].[staff] ([StaffId], [StaffName], [DOB], [Gender], [DepartmentId], [PhoneNumber], [Email], [Salary])
    VALUES (109, 'Varsha', '2002-12-07', 'Female', 2, '8909999999', 'varsha@gmail.com', 90000.00);
SET IDENTITY_INSERT [dbo].[staff] OFF;

-- Login Credentials
SET IDENTITY_INSERT [dbo].[LoginRegistration] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 3)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (3, 'thanya', '10041', 1, 100, 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[LoginRegistration] WHERE [RegistrationId] = 4)
    INSERT INTO [dbo].[LoginRegistration] ([RegistrationId], [Username], [Password], [RoleId], [StaffId], [RIsActive])
    VALUES (4, 'thomas', 'thomas123', 2, 101, 1);
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

-- Doctors
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

-- Medicines & Inventory
SET IDENTITY_INSERT [dbo].[MedicineDetails] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineDetails] WHERE [MedicineId] = 1)
    INSERT INTO [dbo].[MedicineDetails] ([MedicineId], [MedicineName], [Cost], [ManufacturingDate], [ExpiryDate], [CategoryId], [IsActive])
    VALUES (1, N'Paracetamol 500mg', 30.00, '2024-01-01', '2026-01-01', 2, 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineDetails] WHERE [MedicineId] = 2)
    INSERT INTO [dbo].[MedicineDetails] ([MedicineId], [MedicineName], [Cost], [ManufacturingDate], [ExpiryDate], [CategoryId], [IsActive])
    VALUES (2, N'Dolo 650', 120.00, '2024-01-05', '2025-11-08', 2, 1);
SET IDENTITY_INSERT [dbo].[MedicineDetails] OFF;

SET IDENTITY_INSERT [dbo].[MedicineInventory] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineInventory] WHERE [MedicineStockId] = 1)
    INSERT INTO [dbo].[MedicineInventory] ([MedicineStockId], [MedicineId], [StockInHand], [ReOrderLevel], [Purchase], [Issuance], [IsActive])
    VALUES (1, 1, 500, 50, 500, 0, 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[MedicineInventory] WHERE [MedicineStockId] = 2)
    INSERT INTO [dbo].[MedicineInventory] ([MedicineStockId], [MedicineId], [StockInHand], [ReOrderLevel], [Purchase], [Issuance], [IsActive])
    VALUES (2, 2, 350, 30, 400, 50, 1);
SET IDENTITY_INSERT [dbo].[MedicineInventory] OFF;

-- Sample Patients
SET IDENTITY_INSERT [dbo].[Patient] ON;
IF NOT EXISTS (SELECT 1 FROM [dbo].[Patient] WHERE [PatientId] = 1)
    INSERT INTO [dbo].[Patient] ([PatientId], [PatientName], [DOB], [Gender], [BloodGroup], [PatientPhone], [PatientAddress], [RegistrationDate], [IsActive])
    VALUES (1, 'Mathews', '2000-01-17', 'M', 'O+', '7834221231', 'Kannyakumari', '2025-01-25 08:06:44.377', 1);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Patient] WHERE [PatientId] = 2)
    INSERT INTO [dbo].[Patient] ([PatientId], [PatientName], [DOB], [Gender], [BloodGroup], [PatientPhone], [PatientAddress], [RegistrationDate], [IsActive])
    VALUES (2, 'Hannah', '2001-05-12', 'F', 'A-', '8989898090', 'Trivandrum', '2025-01-25 08:41:45.197', 1);
SET IDENTITY_INSERT [dbo].[Patient] OFF;
PRINT '>> Master & Seed Data populated successfully.';
GO

-- ================================================================================
-- PART 4: STORED PROCEDURES
-- ================================================================================

-- 1. sp_AuthenticateUser
CREATE OR ALTER PROCEDURE [dbo].[sp_AuthenticateUser]
    @Username VARCHAR(20),
    @Password VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        lr.RegistrationId, lr.Username, lr.RoleId, r.RoleName, lr.StaffId, s.StaffName,
        s.Email, s.PhoneNumber, s.DepartmentId, d.DepartmentName, doc.DoctorId,
        doc.SpecializationId, sp.SpecializationName, lr.RIsActive
    FROM [dbo].[LoginRegistration] lr
    INNER JOIN [dbo].[Role] r ON lr.RoleId = r.RoleId
    LEFT JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    LEFT JOIN [dbo].[department] d ON s.DepartmentId = d.DepartmentId
    LEFT JOIN [dbo].[doctor] doc ON lr.RegistrationId = doc.RegistrationId
    LEFT JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
    WHERE lr.Username = @Username AND lr.Password = @Password AND lr.RIsActive = 1;
END;
GO

-- 2. sp_RegisterPatient
CREATE OR ALTER PROCEDURE [dbo].[sp_RegisterPatient]
    @PatientName    VARCHAR(50),
    @DOB            DATE,
    @Gender         CHAR(1),
    @BloodGroup     VARCHAR(5),
    @PatientPhone   VARCHAR(10),
    @PatientAddress VARCHAR(250),
    @NewPatientId   INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM [dbo].[Patient] WHERE [PatientPhone] = @PatientPhone AND [IsActive] = 1)
    BEGIN
        SELECT @NewPatientId = [PatientId] FROM [dbo].[Patient] WHERE [PatientPhone] = @PatientPhone AND [IsActive] = 1;
        RETURN;
    END

    INSERT INTO [dbo].[Patient] ([PatientName], [DOB], [Gender], [BloodGroup], [PatientPhone], [PatientAddress], [RegistrationDate], [IsActive])
    VALUES (@PatientName, @DOB, @Gender, @BloodGroup, @PatientPhone, @PatientAddress, GETDATE(), 1);

    SET @NewPatientId = SCOPE_IDENTITY();
END;
GO

-- 3. sp_BookAppointment
CREATE OR ALTER PROCEDURE [dbo].[sp_BookAppointment]
    @PatientId        INT,
    @DoctorId         INT,
    @SpecializationId INT,
    @AppointmentDate  DATE,
    @AvailabilityId   INT,
    @NewAppointmentId INT OUTPUT,
    @GeneratedToken   INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @ConsultationFee DECIMAL(10, 2);
        SELECT @ConsultationFee = ISNULL([ConsultationFee], 300.00) FROM [dbo].[doctor] WHERE [DoctorId] = @DoctorId;

        SELECT @GeneratedToken = ISNULL(MAX(TokenNumber), 0) + 1
        FROM [dbo].[Appointment]
        WHERE [DoctorId] = @DoctorId AND [AppointmentDate] = @AppointmentDate;

        INSERT INTO [dbo].[Appointment]
            ([PatientId], [DoctorId], [SpecializationId], [AppointmentDate], [AvailabilityId], [AppointmentStatusId], [TokenNumber], [RegistrationFee], [ConsultationFee])
        VALUES
            (@PatientId, @DoctorId, @SpecializationId, @AppointmentDate, @AvailabilityId, 2, @GeneratedToken, 150.00, @ConsultationFee);

        SET @NewAppointmentId = SCOPE_IDENTITY();

        INSERT INTO [dbo].[DailyAvailability] ([AppointmentId], [AvailabilityId], [IsAvailable])
        VALUES (@NewAppointmentId, @AvailabilityId, 0);

        INSERT INTO [dbo].[PatientBill] ([AppointmentId], [AppointmentDate], [ConsultationFee], [RegistrationFee], [BillStatusId])
        VALUES (@NewAppointmentId, @AppointmentDate, @ConsultationFee, 150.00, 2);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 4. sp_GetDoctorAvailabilityByDate
CREATE OR ALTER PROCEDURE [dbo].[sp_GetDoctorAvailabilityByDate]
    @DoctorId INT,
    @Date     DATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @DayName VARCHAR(10) = DATENAME(WEEKDAY, @Date);

    SELECT 
        a.AvailabilityId, a.DoctorId, s.StaffName AS DoctorName, sp.SpecializationName,
        doc.ConsultationFee, w.WeekdaysName, ts.TimeSlotId, ts.StartTime, ts.EndTime, a.Session
    FROM [dbo].[availability] a
    INNER JOIN [dbo].[doctor] doc ON a.DoctorId = doc.DoctorId
    INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
    INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    INNER JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
    INNER JOIN [dbo].[timeslot] ts ON a.TimeSlotId = ts.TimeSlotId
    INNER JOIN [dbo].[weekdays] w ON ts.WeekdaysId = w.WeekdaysId
    WHERE a.DoctorId = @DoctorId AND LOWER(w.WeekdaysName) = LOWER(@DayName);
END;
GO

-- 5. sp_GetTodaysPrescribedTests
CREATE OR ALTER PROCEDURE [dbo].[sp_GetTodaysPrescribedTests]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        tp.TP_Id, tp.AppointmentId, apt.TokenNumber, apt.AppointmentDate, p.PatientId,
        p.PatientName, p.DOB, p.Gender, p.BloodGroup, p.PatientPhone, doc.DoctorId,
        s.StaffName AS DoctorName, lt.LabTestId, lt.TestName, lt.LowRange, lt.HighRange,
        lt.Price AS TestPrice, tp.SampleItem
    FROM [dbo].[TestPrescription] tp
    INNER JOIN [dbo].[Appointment] apt ON tp.AppointmentId = apt.AppointmentId
    INNER JOIN [dbo].[Patient] p ON apt.PatientId = p.PatientId
    INNER JOIN [dbo].[doctor] doc ON apt.DoctorId = doc.DoctorId
    INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
    INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    INNER JOIN [dbo].[Labtest] lt ON tp.LabTestId = lt.LabTestId
    WHERE CAST(apt.AppointmentDate AS DATE) = CAST(GETDATE() AS DATE);
END;
GO

-- 6. sp_CreateLabTestReportAndBill
CREATE OR ALTER PROCEDURE [dbo].[sp_CreateLabTestReportAndBill]
    @AppointmentId INT,
    @LabTestId     INT,
    @ActualResult  INT,
    @Remarks       VARCHAR(250),
    @NewReportId   INT OUTPUT,
    @NewBillId     INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @LowRange INT, @HighRange INT, @TestPrice DECIMAL(10, 2);
        SELECT @LowRange = CAST(LowRange AS INT), @HighRange = CAST(HighRange AS INT), @TestPrice = Price 
        FROM [dbo].[Labtest] WHERE [LabTestId] = @LabTestId;

        INSERT INTO [dbo].[LabTestReport]
            ([AppointmentId], [LabTestId], [HighRange], [LowRange], [ActualResult], [Remarks])
        VALUES
            (@AppointmentId, @LabTestId, @HighRange, @LowRange, @ActualResult, @Remarks);

        SET @NewReportId = SCOPE_IDENTITY();

        INSERT INTO [dbo].[LabTestBill] ([LTReportId], [TestPrice], [TestDate], [PaymentDate], [LabTestBillStatusId])
        VALUES (@NewReportId, @TestPrice, GETDATE(), NULL, 2);

        SET @NewBillId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 7. sp_DispenseMedicineAndBill
CREATE OR ALTER PROCEDURE [dbo].[sp_DispenseMedicineAndBill]
    @PrescriptionId INT,
    @Quantity       INT,
    @Remarks        VARCHAR(255) = 'Dispensed by Pharmacy',
    @NewMedDistId   INT OUTPUT,
    @NewMedBillId   INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @MedicineId INT, @AppointmentId INT, @UnitCost DECIMAL(18, 2);
        SELECT @MedicineId = p.MedicineId, @AppointmentId = p.AppointmentId, @UnitCost = md.Cost
        FROM [dbo].[Prescription] p
        INNER JOIN [dbo].[MedicineDetails] md ON p.MedicineId = md.MedicineId
        WHERE p.PrescriptionId = @PrescriptionId;

        DECLARE @CurrentStock INT;
        SELECT @CurrentStock = [StockInHand] FROM [dbo].[MedicineInventory] WHERE [MedicineId] = @MedicineId AND [IsActive] = 1;

        IF @CurrentStock IS NULL OR @CurrentStock < @Quantity
        BEGIN
            RAISERROR('Insufficient stock in inventory.', 16, 1);
            RETURN;
        END

        UPDATE [dbo].[MedicineInventory]
        SET [StockInHand] = [StockInHand] - @Quantity, [Issuance] = ISNULL([Issuance], 0) + @Quantity
        WHERE [MedicineId] = @MedicineId;

        INSERT INTO [dbo].[MedicineDistribution] ([PrescriptionId], [MedicineId], [QuantityDistributed], [MedStatusId], [DistributionDate])
        VALUES (@PrescriptionId, @MedicineId, @Quantity, 2, GETDATE());

        SET @NewMedDistId = SCOPE_IDENTITY();

        DECLARE @DoctorId INT, @PatientId INT;
        SELECT @DoctorId = [DoctorId], @PatientId = [PatientId] FROM [dbo].[Appointment] WHERE [AppointmentId] = @AppointmentId;

        INSERT INTO [dbo].[MedicineBill] ([MedDistId], [DoctorId], [PatientId], [TotalAmount], [PaymentStatusId], [PaymentDate], [Remarks])
        VALUES (@NewMedDistId, @DoctorId, @PatientId, CAST((@UnitCost * @Quantity) AS DECIMAL(10,2)), 2, NULL, @Remarks);

        SET @NewMedBillId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- 8. sp_GetPatientBillSummary
CREATE OR ALTER PROCEDURE [dbo].[sp_GetPatientBillSummary]
    @AppointmentId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Consultation
    SELECT apt.AppointmentId, apt.AppointmentDate, apt.TokenNumber, p.PatientId, p.PatientName,
           s.StaffName AS DoctorName, pb.RegistrationFee, pb.ConsultationFee, pb.TotalFee, bs.BillStatus
    FROM [dbo].[Appointment] apt
    INNER JOIN [dbo].[Patient] p ON apt.PatientId = p.PatientId
    INNER JOIN [dbo].[doctor] doc ON apt.DoctorId = doc.DoctorId
    INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
    INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    LEFT JOIN [dbo].[PatientBill] pb ON apt.AppointmentId = pb.AppointmentId
    LEFT JOIN [dbo].[BillStatus] bs ON pb.BillStatusId = bs.BillStatusId
    WHERE apt.AppointmentId = @AppointmentId;

    -- Diagnostic Bills
    SELECT ltb.LabTestBillId, lt.TestName, ltb.TestPrice, ltb.TestDate, ltbs.LabTestBillStatus
    FROM [dbo].[LabTestReport] ltr
    INNER JOIN [dbo].[LabTestBill] ltb ON ltr.LTReportId = ltb.LTReportId
    INNER JOIN [dbo].[Labtest] lt ON ltr.LabTestId = lt.LabTestId
    INNER JOIN [dbo].[LabTestBillStatus] ltbs ON ltb.LabTestBillStatusId = ltbs.LabTestBillStatusId
    WHERE ltr.AppointmentId = @AppointmentId;

    -- Pharmacy Bills
    SELECT mb.MedicineBillId, md.MedicineName, mdist.QuantityDistributed AS Quantity, md.Cost AS UnitPrice, mb.TotalAmount, mbs.PaymentStatusName
    FROM [dbo].[Prescription] pr
    INNER JOIN [dbo].[MedicineDistribution] mdist ON pr.PrescriptionId = mdist.PrescriptionId
    INNER JOIN [dbo].[MedicineDetails] md ON mdist.MedicineId = md.MedicineId
    INNER JOIN [dbo].[MedicineBill] mb ON mdist.MedDistId = mb.MedDistId
    INNER JOIN [dbo].[MedicineBillStatus] mbs ON mb.PaymentStatusId = mbs.PaymentStatusId
    WHERE pr.AppointmentId = @AppointmentId;
END;
GO
PRINT '>> Stored Procedures verified/created.';
GO

-- ================================================================================
-- PART 5: VIEWS & USER-DEFINED FUNCTIONS
-- ================================================================================

CREATE OR ALTER FUNCTION [dbo].[fn_CalculatePatientAge] (@DOB DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    IF @DOB IS NULL RETURN NULL;
    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
               CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END;
    RETURN @Age;
END;
GO

CREATE OR ALTER VIEW [dbo].[vw_DoctorSchedules]
AS
SELECT 
    doc.DoctorId, s.StaffId, s.StaffName AS DoctorName, sp.SpecializationName,
    doc.ConsultationFee, doc.DoctorIsActive, w.WeekdaysName AS [DayOfWeek],
    ts.StartTime, ts.EndTime, a.Session
FROM [dbo].[doctor] doc
INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
INNER JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
LEFT JOIN [dbo].[availability] a ON doc.DoctorId = a.DoctorId
LEFT JOIN [dbo].[timeslot] ts ON a.TimeSlotId = ts.TimeSlotId
LEFT JOIN [dbo].[weekdays] w ON ts.WeekdaysId = w.WeekdaysId;
GO

CREATE OR ALTER VIEW [dbo].[vw_PatientAppointments]
AS
SELECT 
    apt.AppointmentId, apt.AppointmentDate, apt.TokenNumber, p.PatientId, p.PatientName,
    [dbo].[fn_CalculatePatientAge](p.DOB) AS PatientAge, p.Gender, p.BloodGroup, p.PatientPhone,
    s.StaffName AS DoctorName, sp.SpecializationName, ast.AppointmentStatus,
    apt.RegistrationFee, apt.ConsultationFee, (apt.RegistrationFee + apt.ConsultationFee) AS TotalFee,
    bs.BillStatus AS PaymentStatus
FROM [dbo].[Appointment] apt
INNER JOIN [dbo].[Patient] p ON apt.PatientId = p.PatientId
INNER JOIN [dbo].[doctor] doc ON apt.DoctorId = doc.DoctorId
INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
INNER JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
INNER JOIN [dbo].[AppointmentStatus] ast ON apt.AppointmentStatusId = ast.AppointmentStatusId
LEFT JOIN [dbo].[PatientBill] pb ON apt.AppointmentId = pb.AppointmentId
LEFT JOIN [dbo].[BillStatus] bs ON pb.BillStatusId = bs.BillStatusId;
GO

CREATE OR ALTER VIEW [dbo].[vw_LabTestWorklist]
AS
SELECT 
    tp.TP_Id, apt.AppointmentId, apt.AppointmentDate, apt.TokenNumber, p.PatientId,
    p.PatientName, s.StaffName AS DoctorName, lt.LabTestId, lt.TestName,
    lt.Sample AS ExpectedSample, tp.SampleItem AS CollectedSample, lt.Price,
    ltr.LTReportId, ltr.ActualResult, ltr.Remarks,
    CASE WHEN ltr.LTReportId IS NOT NULL THEN 'Completed' ELSE 'Pending' END AS Status
FROM [dbo].[TestPrescription] tp
INNER JOIN [dbo].[Appointment] apt ON tp.AppointmentId = apt.AppointmentId
INNER JOIN [dbo].[Patient] p ON apt.PatientId = p.PatientId
INNER JOIN [dbo].[doctor] doc ON apt.DoctorId = doc.DoctorId
INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
INNER JOIN [dbo].[Labtest] lt ON tp.LabTestId = lt.LabTestId
LEFT JOIN [dbo].[LabTestReport] ltr ON tp.AppointmentId = ltr.AppointmentId AND tp.LabTestId = ltr.LabTestId;
GO

CREATE OR ALTER VIEW [dbo].[vw_MedicineStockStatus]
AS
SELECT 
    mi.MedicineStockId, md.MedicineId, md.MedicineName, c.CategoryName, md.Cost AS UnitPrice,
    mi.StockInHand, mi.ReOrderLevel,
    CASE 
        WHEN mi.StockInHand <= 0 THEN 'OUT OF STOCK'
        WHEN mi.StockInHand <= mi.ReOrderLevel THEN 'LOW STOCK - REORDER'
        ELSE 'SUFFICIENT'
    END AS StockStatus
FROM [dbo].[MedicineInventory] mi
INNER JOIN [dbo].[MedicineDetails] md ON mi.MedicineId = md.MedicineId
INNER JOIN [dbo].[Category] c ON md.CategoryId = c.CategoryId;
GO

PRINT '================================================================================';
PRINT 'MASTER DEPLOYMENT SCRIPT COMPLETED SUCCESSFULLY FOR [ClinicManagementSys]!';
PRINT '================================================================================';
GO
