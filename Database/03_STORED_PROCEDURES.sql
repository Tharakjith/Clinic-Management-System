/*
================================================================================
   CLINIC MANAGEMENT SYSTEM (CMS) - STORED PROCEDURES
   File: 03_STORED_PROCEDURES.sql
   Target Database: ClinicManagementSys
   Description: Stored procedures for authentication, patient booking,
                token generation, diagnostics, and pharmaceutical billing.
================================================================================
*/

USE [ClinicManagementSys];
GO

-- ================================================================================
-- 1. SP: Authenticate User & Fetch Profile
-- ================================================================================
CREATE OR ALTER PROCEDURE [dbo].[sp_AuthenticateUser]
    @Username VARCHAR(20),
    @Password VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        lr.RegistrationId,
        lr.Username,
        lr.RoleId,
        r.RoleName,
        lr.StaffId,
        s.StaffName,
        s.Email,
        s.PhoneNumber,
        s.DepartmentId,
        d.DepartmentName,
        doc.DoctorId,
        doc.SpecializationId,
        sp.SpecializationName,
        lr.RIsActive
    FROM [dbo].[LoginRegistration] lr
    INNER JOIN [dbo].[Role] r ON lr.RoleId = r.RoleId
    LEFT JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    LEFT JOIN [dbo].[department] d ON s.DepartmentId = d.DepartmentId
    LEFT JOIN [dbo].[doctor] doc ON lr.RegistrationId = doc.RegistrationId
    LEFT JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
    WHERE lr.Username = @Username 
      AND lr.Password = @Password
      AND lr.RIsActive = 1;
END;
GO
PRINT 'Procedure [sp_AuthenticateUser] created/updated.';
GO

-- ================================================================================
-- 2. SP: Register New Patient
-- ================================================================================
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
        SELECT @NewPatientId = [PatientId] 
        FROM [dbo].[Patient] 
        WHERE [PatientPhone] = @PatientPhone AND [IsActive] = 1;
        RETURN;
    END

    INSERT INTO [dbo].[Patient] 
        ([PatientName], [DOB], [Gender], [BloodGroup], [PatientPhone], [PatientAddress], [RegistrationDate], [IsActive])
    VALUES 
        (@PatientName, @DOB, @Gender, @BloodGroup, @PatientPhone, @PatientAddress, GETDATE(), 1);

    SET @NewPatientId = SCOPE_IDENTITY();
END;
GO
PRINT 'Procedure [sp_RegisterPatient] created/updated.';
GO

-- ================================================================================
-- 3. SP: Book Appointment with Auto-Generated Token & Billing
-- ================================================================================
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
        -- 1. Fetch Doctor's Consultation Fee
        DECLARE @ConsultationFee DECIMAL(10, 2);
        SELECT @ConsultationFee = [ConsultationFee] 
        FROM [dbo].[doctor] 
        WHERE [DoctorId] = @DoctorId;

        IF @ConsultationFee IS NULL
            SET @ConsultationFee = 300.00;

        -- 2. Calculate Next Token Number for the doctor on this date
        SELECT @GeneratedToken = ISNULL(MAX(TokenNumber), 0) + 1
        FROM [dbo].[Appointment]
        WHERE [DoctorId] = @DoctorId 
          AND [AppointmentDate] = @AppointmentDate;

        -- 3. Insert Appointment (Default Registration Fee = 150.00, Status = 2: Pending)
        INSERT INTO [dbo].[Appointment]
            ([PatientId], [DoctorId], [SpecializationId], [AppointmentDate], [AvailabilityId], [AppointmentStatusId], [TokenNumber], [RegistrationFee], [ConsultationFee])
        VALUES
            (@PatientId, @DoctorId, @SpecializationId, @AppointmentDate, @AvailabilityId, 2, @GeneratedToken, 150.00, @ConsultationFee);

        SET @NewAppointmentId = SCOPE_IDENTITY();

        -- 4. Mark Daily Availability
        INSERT INTO [dbo].[DailyAvailability] ([AppointmentId], [AvailabilityId], [IsAvailable])
        VALUES (@NewAppointmentId, @AvailabilityId, 0);

        -- 5. Auto-Generate Patient Consultation Bill (BillStatus = 2: Unpaid)
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
PRINT 'Procedure [sp_BookAppointment] created/updated.';
GO

-- ================================================================================
-- 4. SP: Get Doctor Availability for a Given Date
-- ================================================================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetDoctorAvailabilityByDate]
    @DoctorId INT,
    @Date     DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DayName VARCHAR(10) = DATENAME(WEEKDAY, @Date);

    SELECT 
        a.AvailabilityId,
        a.DoctorId,
        s.StaffName AS DoctorName,
        sp.SpecializationName,
        doc.ConsultationFee,
        w.WeekdaysName,
        ts.TimeSlotId,
        ts.StartTime,
        ts.EndTime,
        a.Session
    FROM [dbo].[availability] a
    INNER JOIN [dbo].[doctor] doc ON a.DoctorId = doc.DoctorId
    INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
    INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    INNER JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
    INNER JOIN [dbo].[timeslot] ts ON a.TimeSlotId = ts.TimeSlotId
    INNER JOIN [dbo].[weekdays] w ON ts.WeekdaysId = w.WeekdaysId
    WHERE a.DoctorId = @DoctorId
      AND LOWER(w.WeekdaysName) = LOWER(@DayName);
END;
GO
PRINT 'Procedure [sp_GetDoctorAvailabilityByDate] created/updated.';
GO

-- ================================================================================
-- 5. SP: Get Today's Prescribed Lab Tests Queue
-- ================================================================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetTodaysPrescribedTests]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        tp.TP_Id,
        tp.AppointmentId,
        apt.TokenNumber,
        apt.AppointmentDate,
        p.PatientId,
        p.PatientName,
        p.DOB,
        p.Gender,
        p.BloodGroup,
        p.PatientPhone,
        doc.DoctorId,
        s.StaffName AS DoctorName,
        lt.LabTestId,
        lt.TestName,
        lt.LowRange,
        lt.HighRange,
        lt.Price AS TestPrice,
        tp.SampleItem
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
PRINT 'Procedure [sp_GetTodaysPrescribedTests] created/updated.';
GO

-- ================================================================================
-- 6. SP: Create Lab Test Report & Generate Lab Bill
-- ================================================================================
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
        SELECT 
            @LowRange = CAST(LowRange AS INT), 
            @HighRange = CAST(HighRange AS INT), 
            @TestPrice = Price 
        FROM [dbo].[Labtest] 
        WHERE [LabTestId] = @LabTestId;

        -- 1. Insert Lab Test Report
        INSERT INTO [dbo].[LabTestReport]
            ([AppointmentId], [LabTestId], [LowRange], [HighRange], [ActualResult], [Remarks])
        VALUES
            (@AppointmentId, @LabTestId, @LowRange, @HighRange, @ActualResult, @Remarks);

        SET @NewReportId = SCOPE_IDENTITY();

        -- 2. Generate Lab Test Bill (Status = 2: Unpaid)
        INSERT INTO [dbo].[LabTestBill]
            ([LTReportId], [TestPrice], [TestDate], [PaymentDate], [LabTestBillStatusId])
        VALUES
            (@NewReportId, @TestPrice, GETDATE(), NULL, 2);

        SET @NewBillId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
PRINT 'Procedure [sp_CreateLabTestReportAndBill] created/updated.';
GO

-- ================================================================================
-- 7. SP: Dispense Medicine, Deduct Stock & Generate Pharmacy Bill
-- ================================================================================
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
        SELECT 
            @MedicineId = p.MedicineId,
            @AppointmentId = p.AppointmentId,
            @UnitCost = md.Cost
        FROM [dbo].[Prescription] p
        INNER JOIN [dbo].[MedicineDetails] md ON p.MedicineId = md.MedicineId
        WHERE p.PrescriptionId = @PrescriptionId;

        IF @MedicineId IS NULL
        BEGIN
            RAISERROR('Prescription not found.', 16, 1);
            RETURN;
        END

        DECLARE @CurrentStock INT;
        SELECT @CurrentStock = [StockInHand]
        FROM [dbo].[MedicineInventory]
        WHERE [MedicineId] = @MedicineId AND [IsActive] = 1;

        IF @CurrentStock IS NULL OR @CurrentStock < @Quantity
        BEGIN
            RAISERROR('Insufficient stock in inventory for this medicine.', 16, 1);
            RETURN;
        END

        UPDATE [dbo].[MedicineInventory]
        SET [StockInHand] = [StockInHand] - @Quantity,
            [Issuance]    = ISNULL([Issuance], 0) + @Quantity
        WHERE [MedicineId] = @MedicineId;

        INSERT INTO [dbo].[MedicineDistribution]
            ([PrescriptionId], [MedicineId], [QuantityDistributed], [MedStatusId], [DistributionDate])
        VALUES
            (@PrescriptionId, @MedicineId, @Quantity, 2, GETDATE());

        SET @NewMedDistId = SCOPE_IDENTITY();

        DECLARE @DoctorId INT, @PatientId INT;
        SELECT @DoctorId = [DoctorId], @PatientId = [PatientId]
        FROM [dbo].[Appointment]
        WHERE [AppointmentId] = @AppointmentId;

        DECLARE @TotalAmount DECIMAL(10, 2) = CAST((@UnitCost * @Quantity) AS DECIMAL(10, 2));

        INSERT INTO [dbo].[MedicineBill]
            ([MedDistId], [DoctorId], [PatientId], [TotalAmount], [PaymentStatusId], [PaymentDate], [Remarks])
        VALUES
            (@NewMedDistId, @DoctorId, @PatientId, @TotalAmount, 2, NULL, @Remarks);

        SET @NewMedBillId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
PRINT 'Procedure [sp_DispenseMedicineAndBill] created/updated.';
GO

-- ================================================================================
-- 8. SP: Comprehensive Patient Billing Summary for an Appointment
-- ================================================================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetPatientBillSummary]
    @AppointmentId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Patient & Appointment Info
    SELECT 
        apt.AppointmentId,
        apt.AppointmentDate,
        apt.TokenNumber,
        p.PatientId,
        p.PatientName,
        p.PatientPhone,
        s.StaffName AS DoctorName,
        sp.SpecializationName,
        pb.PatientBillId,
        pb.RegistrationFee,
        pb.ConsultationFee,
        pb.TotalFee AS ConsultationTotal,
        bs.BillStatus AS ConsultationPaymentStatus
    FROM [dbo].[Appointment] apt
    INNER JOIN [dbo].[Patient] p ON apt.PatientId = p.PatientId
    INNER JOIN [dbo].[doctor] doc ON apt.DoctorId = doc.DoctorId
    INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
    INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
    INNER JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
    LEFT JOIN [dbo].[PatientBill] pb ON apt.AppointmentId = pb.AppointmentId
    LEFT JOIN [dbo].[BillStatus] bs ON pb.BillStatusId = bs.BillStatusId
    WHERE apt.AppointmentId = @AppointmentId;

    -- Diagnostic Lab Bills
    SELECT 
        ltb.LabTestBillId,
        lt.TestName,
        ltb.TestPrice,
        ltb.TestDate,
        ltbs.LabTestBillStatus AS PaymentStatus
    FROM [dbo].[LabTestReport] ltr
    INNER JOIN [dbo].[LabTestBill] ltb ON ltr.LTReportId = ltb.LTReportId
    INNER JOIN [dbo].[Labtest] lt ON ltr.LabTestId = lt.LabTestId
    INNER JOIN [dbo].[LabTestBillStatus] ltbs ON ltb.LabTestBillStatusId = ltbs.LabTestBillStatusId
    WHERE ltr.AppointmentId = @AppointmentId;

    -- Pharmacy Medicine Bills
    SELECT 
        mb.MedicineBillId,
        md.MedicineName,
        mdist.QuantityDistributed AS Quantity,
        md.Cost AS UnitPrice,
        mb.TotalAmount,
        mbs.PaymentStatusName AS PaymentStatus
    FROM [dbo].[Prescription] pr
    INNER JOIN [dbo].[MedicineDistribution] mdist ON pr.PrescriptionId = mdist.PrescriptionId
    INNER JOIN [dbo].[MedicineDetails] md ON mdist.MedicineId = md.MedicineId
    INNER JOIN [dbo].[MedicineBill] mb ON mdist.MedDistId = mb.MedDistId
    INNER JOIN [dbo].[MedicineBillStatus] mbs ON mb.PaymentStatusId = mbs.PaymentStatusId
    WHERE pr.AppointmentId = @AppointmentId;
END;
GO
PRINT 'Procedure [sp_GetPatientBillSummary] created/updated.';
GO

PRINT '================================================================================';
PRINT 'All 8 Stored Procedures created successfully for ClinicManagementSys.';
PRINT '================================================================================';
GO
