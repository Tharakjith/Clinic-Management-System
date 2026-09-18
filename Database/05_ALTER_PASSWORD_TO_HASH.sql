-- ================================================================================
-- CLINIC MANAGEMENT SYSTEM (CMS) - MIGRATION SCRIPT
-- File: 05_ALTER_PASSWORD_TO_HASH.sql
-- Purpose: Expand Password column in LoginRegistration table to VARCHAR(128)
--          to safely support industrial salted BCrypt password hashes.
-- ================================================================================

USE [ClinicManagementSys];
GO

IF EXISTS (
    SELECT * FROM sys.columns 
    WHERE object_id = OBJECT_ID(N'[dbo].[LoginRegistration]') 
    AND name = 'Password' 
    AND max_length < 128
)
BEGIN
    ALTER TABLE [dbo].[LoginRegistration] ALTER COLUMN [Password] VARCHAR(128) NOT NULL;
    PRINT '>> SUCCESS: Column [Password] in [LoginRegistration] altered to VARCHAR(128).';
END
ELSE
BEGIN
    PRINT '>> Column [Password] in [LoginRegistration] is already VARCHAR(128) or higher.';
END
GO
