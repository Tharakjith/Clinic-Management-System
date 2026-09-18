/*
================================================================================
   CLINIC MANAGEMENT SYSTEM (CMS) - DATABASE DDL SCRIPT
   File: 01_CREATE_DATABASE_AND_TABLES.sql
   Target Engine: Microsoft SQL Server (2019 / 2022 / Azure SQL)
   Description: Creates the ClinicManagementSys database and all 29 tables
                with Primary Keys, Foreign Keys, Defaults, and Computed Columns.
================================================================================
*/

-- 1. Create Database if it does not already exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ClinicManagementSys')
BEGIN
    CREATE DATABASE [ClinicManagementSys];
    PRINT 'Database [ClinicManagementSys] created successfully.';
END
ELSE
BEGIN
    PRINT 'Database [ClinicManagementSys] already exists.';
END
GO

USE [ClinicManagementSys];
GO

-- ================================================================================
-- LEVEL 0: LOOKUP & BASE TABLES (NO FOREIGN KEY DEPENDENCIES)
-- ================================================================================

-- 1. Role Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Role')
BEGIN
    CREATE TABLE [dbo].[Role] (
        [RoleId]   INT IDENTITY(1,1) NOT NULL,
        [RoleName] VARCHAR(15) NULL,
        CONSTRAINT [PK__Role__8AFACE1A31305CBA] PRIMARY KEY CLUSTERED ([RoleId] ASC)
    );
    PRINT 'Table [Role] created.';
END
GO

-- 2. Department Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'department')
BEGIN
    CREATE TABLE [dbo].[department] (
        [DepartmentId]   INT IDENTITY(1,1) NOT NULL,
        [DepartmentName] VARCHAR(20) NULL,
        CONSTRAINT [PK__departme__B2079BEDDEC53583] PRIMARY KEY CLUSTERED ([DepartmentId] ASC)
    );
    PRINT 'Table [department] created.';
END
GO

-- 3. Specialization Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'specialization')
BEGIN
    CREATE TABLE [dbo].[specialization] (
        [SpecializationId]   INT IDENTITY(1,1) NOT NULL,
        [SpecializationName] VARCHAR(30) NULL,
        CONSTRAINT [PK__speciali__5809D86F5BE2A555] PRIMARY KEY CLUSTERED ([SpecializationId] ASC)
    );
    PRINT 'Table [specialization] created.';
END
GO

-- 4. Weekdays Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'weekdays')
BEGIN
    CREATE TABLE [dbo].[weekdays] (
        [WeekdaysId]   INT IDENTITY(1,1) NOT NULL,
        [WeekdaysName] VARCHAR(10) NULL,
        CONSTRAINT [PK__weekdays__D053E4AF0183A13F] PRIMARY KEY CLUSTERED ([WeekdaysId] ASC)
    );
    PRINT 'Table [weekdays] created.';
END
GO

-- 5. AppointmentStatus Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'AppointmentStatus')
BEGIN
    CREATE TABLE [dbo].[AppointmentStatus] (
        [AppointmentStatusId] INT NOT NULL,
        [AppointmentStatus]   VARCHAR(20) NULL,
        CONSTRAINT [PK__Appointm__A619B660C61691C6] PRIMARY KEY CLUSTERED ([AppointmentStatusId] ASC),
        CONSTRAINT [UQ__Appointm__BABC696605623C0C] UNIQUE NONCLUSTERED ([AppointmentStatus] ASC)
    );
    PRINT 'Table [AppointmentStatus] created.';
END
GO

-- 6. BillStatus Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'BillStatus')
BEGIN
    CREATE TABLE [dbo].[BillStatus] (
        [BillStatusId] INT NOT NULL,
        [BillStatus]   VARCHAR(20) NULL,
        CONSTRAINT [PK__BillStat__C3D12851881A8593] PRIMARY KEY CLUSTERED ([BillStatusId] ASC),
        CONSTRAINT [UQ__BillStat__662BD8AEFBCAAA39] UNIQUE NONCLUSTERED ([BillStatus] ASC)
    );
    PRINT 'Table [BillStatus] created.';
END
GO

-- 7. Category Table (Medicine Categories)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Category')
BEGIN
    CREATE TABLE [dbo].[Category] (
        [CategoryId]   INT IDENTITY(1,1) NOT NULL,
        [CategoryName] NVARCHAR(50) NULL,
        CONSTRAINT [PK__Category__19093A0BA1E1AFB3] PRIMARY KEY CLUSTERED ([CategoryId] ASC)
    );
    PRINT 'Table [Category] created.';
END
GO

-- 8. LabTestBillStatus Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'LabTestBillStatus')
BEGIN
    CREATE TABLE [dbo].[LabTestBillStatus] (
        [LabTestBillStatusId] INT NOT NULL,
        [LabTestBillStatus]   VARCHAR(20) NULL,
        CONSTRAINT [PK__LabTestB__224C5B0E5B1E91A1] PRIMARY KEY CLUSTERED ([LabTestBillStatusId] ASC),
        CONSTRAINT [UQ__LabTestB__15FEC2E2642FE6EA] UNIQUE NONCLUSTERED ([LabTestBillStatus] ASC)
    );
    PRINT 'Table [LabTestBillStatus] created.';
END
GO

-- 9. MedDistributionStatus Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedDistributionStatus')
BEGIN
    CREATE TABLE [dbo].[MedDistributionStatus] (
        [MedStatusId]   INT NOT NULL,
        [MedStatusName] VARCHAR(20) NULL,
        CONSTRAINT [PK__MedDistr__1DC2948723C48B90] PRIMARY KEY CLUSTERED ([MedStatusId] ASC),
        CONSTRAINT [UQ__MedDistr__F3A409D9B9E0B6A5] UNIQUE NONCLUSTERED ([MedStatusName] ASC)
    );
    PRINT 'Table [MedDistributionStatus] created.';
END
GO

-- 10. MedicineBillStatus Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'MedicineBillStatus')
BEGIN
    CREATE TABLE [dbo].[MedicineBillStatus] (
        [PaymentStatusId]   INT NOT NULL,
        [PaymentStatusName] VARCHAR(20) NULL,
        CONSTRAINT [PK__Medicine__34F8AC3FC2A7B38F] PRIMARY KEY CLUSTERED ([PaymentStatusId] ASC),
        CONSTRAINT [UQ__Medicine__BBAC58DB9D7DD3A6] UNIQUE NONCLUSTERED ([PaymentStatusName] ASC)
    );
    PRINT 'Table [MedicineBillStatus] created.';
END
GO

-- 11. Labtest Master Table
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
    PRINT 'Table [Labtest] created.';
END
GO

-- 12. Patient Master Table
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
    PRINT 'Table [Patient] created.';
END
GO

-- ================================================================================
-- LEVEL 1: DIRECT DEPENDENTS (LEVEL 0 REFS)
-- ================================================================================

-- 13. Staff Table
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
    PRINT 'Table [staff] created.';
END
GO

-- 14. Timeslot Table
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
    PRINT 'Table [timeslot] created.';
END
GO

-- 15. MedicineDetails Table
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
    PRINT 'Table [MedicineDetails] created.';
END
GO

-- ================================================================================
-- LEVEL 2: AUTH & INVENTORY DEPENDENTS
-- ================================================================================

-- 16. LoginRegistration Table
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
    PRINT 'Table [LoginRegistration] created.';
END
GO

-- 17. MedicineInventory Table
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
    PRINT 'Table [MedicineInventory] created.';
END
GO

-- ================================================================================
-- LEVEL 3: CLINICAL & SCHEDULING DEPENDENTS
-- ================================================================================

-- 18. Doctor Table
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
    PRINT 'Table [doctor] created.';
END
GO

-- 19. Availability Table
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
    PRINT 'Table [availability] created.';
END
GO

-- ================================================================================
-- LEVEL 4: APPOINTMENTS
-- ================================================================================

-- 20. Appointment Table
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
    PRINT 'Table [Appointment] created.';
END
GO

-- ================================================================================
-- LEVEL 5: APPOINTMENT ASSOCIATIONS & CLINICAL OBSERVATIONS
-- ================================================================================

-- 21. DailyAvailability Table
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
    PRINT 'Table [DailyAvailability] created.';
END
GO

-- 22. PatientBill Table (Consultation Billing with Computed Column)
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
    PRINT 'Table [PatientBill] created.';
END
GO

-- 23. StartDiagnosys Table
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
    PRINT 'Table [StartDiagnosys] created.';
END
GO

-- 24. Prescription Table (Doctor Prescriptions)
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
    PRINT 'Table [Prescription] created.';
END
GO

-- 25. TestPrescription Table (Lab Orders)
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
    PRINT 'Table [TestPrescription] created.';
END
GO

-- ================================================================================
-- LEVEL 6: DIAGNOSTICS & DRUG DISTRIBUTION
-- ================================================================================

-- 26. MedicineDistribution Table
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
    PRINT 'Table [MedicineDistribution] created.';
END
GO

-- 27. LabTestReport Table
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
    PRINT 'Table [LabTestReport] created.';
END
GO

-- ================================================================================
-- LEVEL 7: FINAL INVOICING & BILLING
-- ================================================================================

-- 28. MedicineBill Table (Pharmacy Invoice)
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
    PRINT 'Table [MedicineBill] created.';
END
GO

-- 29. LabTestBill Table (Diagnostic Invoice)
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
    PRINT 'Table [LabTestBill] created.';
END
GO

PRINT '================================================================================';
PRINT 'All 29 tables created successfully for ClinicManagementSys database.';
PRINT '================================================================================';
GO
