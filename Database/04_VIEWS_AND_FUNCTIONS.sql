/*
================================================================================
   CLINIC MANAGEMENT SYSTEM (CMS) - VIEWS & USER-DEFINED FUNCTIONS
   File: 04_VIEWS_AND_FUNCTIONS.sql
   Target Database: ClinicManagementSys
   Description: Analytical views and helper scalar/table functions for CMS.
================================================================================
*/

USE [ClinicManagementSys];
GO

-- ================================================================================
-- 1. FUNCTION: Calculate Patient Age from DOB
-- ================================================================================
CREATE OR ALTER FUNCTION [dbo].[fn_CalculatePatientAge] (@DOB DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    IF @DOB IS NULL RETURN NULL;

    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
               CASE 
                   WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) 
                   THEN 1 
                   ELSE 0 
               END;
    RETURN @Age;
END;
GO
PRINT 'Function [fn_CalculatePatientAge] created/updated.';
GO

-- ================================================================================
-- 2. FUNCTION: Get Next Token Number for a Doctor on a Specific Date
-- ================================================================================
CREATE OR ALTER FUNCTION [dbo].[fn_GetNextTokenNumber] (@DoctorId INT, @AppointmentDate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @NextToken INT;
    SELECT @NextToken = ISNULL(MAX(TokenNumber), 0) + 1
    FROM [dbo].[Appointment]
    WHERE [DoctorId] = @DoctorId AND [AppointmentDate] = @AppointmentDate;

    RETURN @NextToken;
END;
GO
PRINT 'Function [fn_GetNextTokenNumber] created/updated.';
GO

-- ================================================================================
-- 3. VIEW: Active Doctor Schedules & Time Slots
-- ================================================================================
CREATE OR ALTER VIEW [dbo].[vw_DoctorSchedules]
AS
SELECT 
    doc.DoctorId,
    s.StaffId,
    s.StaffName AS DoctorName,
    s.PhoneNumber AS DoctorPhone,
    s.Email AS DoctorEmail,
    sp.SpecializationId,
    sp.SpecializationName,
    doc.ConsultationFee,
    doc.DoctorIsActive,
    a.AvailabilityId,
    w.WeekdaysId,
    w.WeekdaysName AS [DayOfWeek],
    ts.TimeSlotId,
    CONVERT(VARCHAR(8), ts.StartTime, 108) AS StartTime,
    CONVERT(VARCHAR(8), ts.EndTime, 108) AS EndTime,
    a.Session
FROM [dbo].[doctor] doc
INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
INNER JOIN [dbo].[specialization] sp ON doc.SpecializationId = sp.SpecializationId
LEFT JOIN [dbo].[availability] a ON doc.DoctorId = a.DoctorId
LEFT JOIN [dbo].[timeslot] ts ON a.TimeSlotId = ts.TimeSlotId
LEFT JOIN [dbo].[weekdays] w ON ts.WeekdaysId = w.WeekdaysId;
GO
PRINT 'View [vw_DoctorSchedules] created/updated.';
GO

-- ================================================================================
-- 4. VIEW: Patient Appointments Full Register
-- ================================================================================
CREATE OR ALTER VIEW [dbo].[vw_PatientAppointments]
AS
SELECT 
    apt.AppointmentId,
    apt.AppointmentDate,
    apt.TokenNumber,
    p.PatientId,
    p.PatientName,
    [dbo].[fn_CalculatePatientAge](p.DOB) AS PatientAge,
    p.Gender,
    p.BloodGroup,
    p.PatientPhone,
    doc.DoctorId,
    s.StaffName AS DoctorName,
    sp.SpecializationName,
    ast.AppointmentStatusId,
    ast.AppointmentStatus,
    apt.RegistrationFee,
    apt.ConsultationFee,
    (apt.RegistrationFee + apt.ConsultationFee) AS TotalConsultationCharge,
    pb.PatientBillId,
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
PRINT 'View [vw_PatientAppointments] created/updated.';
GO

-- ================================================================================
-- 5. VIEW: Laboratory Worklist & Investigation Tracker
-- ================================================================================
CREATE OR ALTER VIEW [dbo].[vw_LabTestWorklist]
AS
SELECT 
    tp.TP_Id,
    apt.AppointmentId,
    apt.AppointmentDate,
    apt.TokenNumber,
    p.PatientId,
    p.PatientName,
    p.PatientPhone,
    s.StaffName AS PrescribedByDoctor,
    lt.LabTestId,
    lt.TestName,
    lt.Sample AS ExpectedSample,
    tp.SampleItem AS CollectedSample,
    lt.LowRange,
    lt.HighRange,
    lt.Price AS TestPrice,
    ltr.LTReportId,
    ltr.ActualResult,
    ltr.Remarks AS DiagnosticRemarks,
    ltr.TestDate AS CompletedDate,
    CASE 
        WHEN ltr.LTReportId IS NOT NULL THEN 'Completed'
        ELSE 'Pending'
    END AS InvestigationStatus
FROM [dbo].[TestPrescription] tp
INNER JOIN [dbo].[Appointment] apt ON tp.AppointmentId = apt.AppointmentId
INNER JOIN [dbo].[Patient] p ON apt.PatientId = p.PatientId
INNER JOIN [dbo].[doctor] doc ON apt.DoctorId = doc.DoctorId
INNER JOIN [dbo].[LoginRegistration] lr ON doc.RegistrationId = lr.RegistrationId
INNER JOIN [dbo].[staff] s ON lr.StaffId = s.StaffId
INNER JOIN [dbo].[Labtest] lt ON tp.LabTestId = lt.LabTestId
LEFT JOIN [dbo].[LabTestReport] ltr ON tp.AppointmentId = ltr.AppointmentId AND tp.LabTestId = ltr.LabTestId;
GO
PRINT 'View [vw_LabTestWorklist] created/updated.';
GO

-- ================================================================================
-- 6. VIEW: Pharmacy Inventory & Stock Alert Monitor
-- ================================================================================
CREATE OR ALTER VIEW [dbo].[vw_MedicineStockStatus]
AS
SELECT 
    mi.MedicineStockId,
    md.MedicineId,
    md.MedicineName,
    c.CategoryName,
    md.Cost AS UnitPrice,
    md.ManufacturingDate,
    md.ExpiryDate,
    mi.StockInHand,
    mi.ReOrderLevel,
    mi.Purchase AS TotalPurchased,
    mi.Issuance AS TotalDispensed,
    CASE 
        WHEN mi.StockInHand <= 0 THEN 'OUT OF STOCK'
        WHEN mi.StockInHand <= mi.ReOrderLevel THEN 'LOW STOCK - REORDER'
        ELSE 'SUFFICIENT'
    END AS StockStatus,
    CASE 
        WHEN md.ExpiryDate < CAST(GETDATE() AS DATE) THEN 'EXPIRED'
        WHEN DATEDIFF(DAY, GETDATE(), md.ExpiryDate) <= 90 THEN 'EXPIRING SOON (<90 DAYS)'
        ELSE 'VALID'
    END AS ExpiryAlert
FROM [dbo].[MedicineInventory] mi
INNER JOIN [dbo].[MedicineDetails] md ON mi.MedicineId = md.MedicineId
INNER JOIN [dbo].[Category] c ON md.CategoryId = c.CategoryId;
GO
PRINT 'View [vw_MedicineStockStatus] created/updated.';
GO

-- ================================================================================
-- 7. VIEW: Consolidated Daily Clinic Financial Summary
-- ================================================================================
CREATE OR ALTER VIEW [dbo].[vw_DailyClinicRevenue]
AS
SELECT 
    DailySummary.RevenueDate,
    ISNULL(DailySummary.ConsultationRevenue, 0) AS ConsultationRevenue,
    ISNULL(DailySummary.PharmacyRevenue, 0) AS PharmacyRevenue,
    ISNULL(DailySummary.LaboratoryRevenue, 0) AS LaboratoryRevenue,
    (ISNULL(DailySummary.ConsultationRevenue, 0) + 
     ISNULL(DailySummary.PharmacyRevenue, 0) + 
     ISNULL(DailySummary.LaboratoryRevenue, 0)) AS TotalDailyRevenue
FROM (
    SELECT 
        Dates.RevenueDate,
        (SELECT SUM(pb.TotalFee) FROM [dbo].[PatientBill] pb WHERE pb.AppointmentDate = Dates.RevenueDate AND pb.BillStatusId = 1) AS ConsultationRevenue,
        (SELECT SUM(mb.TotalAmount) FROM [dbo].[MedicineBill] mb WHERE CAST(mb.PaymentDate AS DATE) = Dates.RevenueDate AND mb.PaymentStatusId = 1) AS PharmacyRevenue,
        (SELECT SUM(ltb.TestPrice) FROM [dbo].[LabTestBill] ltb WHERE CAST(ltb.PaymentDate AS DATE) = Dates.RevenueDate AND ltb.LabTestBillStatusId = 1) AS LaboratoryRevenue
    FROM (
        SELECT DISTINCT AppointmentDate AS RevenueDate FROM [dbo].[PatientBill] WHERE AppointmentDate IS NOT NULL
        UNION
        SELECT DISTINCT CAST(PaymentDate AS DATE) FROM [dbo].[MedicineBill] WHERE PaymentDate IS NOT NULL
        UNION
        SELECT DISTINCT CAST(PaymentDate AS DATE) FROM [dbo].[LabTestBill] WHERE PaymentDate IS NOT NULL
    ) Dates
) DailySummary;
GO
PRINT 'View [vw_DailyClinicRevenue] created/updated.';
GO

PRINT '================================================================================';
PRINT 'All Views and Functions created successfully for ClinicManagementSys.';
PRINT '================================================================================';
GO
