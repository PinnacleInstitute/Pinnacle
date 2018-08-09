EXEC [dbo].pts_CheckProc 'pts_CloudZow_CustomList'
GO

-- EXEC pts_CloudZow_CustomList 3, 0, 0, 0

CREATE PROCEDURE [dbo].pts_CloudZow_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @Today datetime, @ToDate datetime

SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- List all payments to process
IF @Status = 1
BEGIN
	SELECT pa.PaymentID AS 'CloudZowID', CAST(pa.PaymentID AS VARCHAR(10)) + '|' + CAST(pa.PayType AS VARCHAR(10)) + '|' + CAST(pa.Amount AS VARCHAR(10)) + '|' + me.Reference + '|' + CAST(pa.TokenType AS VARCHAR(10)) + '|' + CAST(pa.Token AS VARCHAR(15)) AS 'Result'
	FROM Payment AS pa (NOLOCK)
	JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
	WHERE me.CompanyID = 5 AND pa.Status = 1 AND pa.Amount <> 0
	AND pa.PayType >= 1 AND pa.PayType <= 4
	ORDER BY pa.PaymentID
END
-- List all active machines for updating backup data
IF @Status = 2
BEGIN
	SELECT MachineID AS 'CloudZowID', '' AS 'Result'
	FROM Machine AS ma (NOLOCK)
	JOIN Member AS me ON ma.MemberID = me.MemberID
	WHERE me.Status >= 1 AND me.Status <= 4 AND me.GroupID <> 100
	AND ma.Status = 2 AND LiveDriveID > 0
	ORDER BY ma.MachineID DESC
END
-- List all new eWallets to create
IF @Status = 3
BEGIN
--UserName,FirstName,LastName,CompanyName,Address1,Address2,City,State,ZipCode,Country2xFormat,PhoneNumber,CellPhoneNumber,EmailAddress,SSN,CompanyTaxID,GovernmentID,MilitaryID,PassportNumber,DriversLicense,DateOfBirth,WebsitePassword,DefaultCurrency,PreferredLanguage
	SELECT me.MemberID AS 'CloudZowID', '"' + au.Logon + '","' + me.NameFirst + '","' + me.NameLast + '",,,,,,,,,,"' + me.Email + '",,,,,,,,"' + au.Password + '",,' AS 'Result'
	FROM Member AS me
	JOIN Address AS ad ON me.MemberID = ad.OwnerID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE CompanyID = 5 AND Status = 1 AND Level = 1
	AND ad.AddressType = 2 AND ad.IsActive = 1 AND ad.CountryID <> 224
	AND me.ConfLine = ''
	order by me.NameLast, me.namefirst
END

-- List all active machines with no backup
IF @Status = 4
BEGIN
	SELECT MachineID AS 'CloudZowID', '' AS 'Result'
	FROM Machine AS ma (NOLOCK)
	JOIN Member AS me ON ma.MemberID = me.MemberID
	WHERE me.Status >= 1 AND me.Status <= 4 AND me.GroupID <> 100
	AND ma.Status = 2 AND LiveDriveID > 0
	AND ( ma.BackupUsed = '' OR  ma.BackupUsed = '0 B' )
	ORDER BY ma.MachineID DESC
END

-- List all active free trial computers over 30 days
IF @Status = 5
BEGIN
	SET @ToDate = DATEADD(d, -30, @Today)
	
	SELECT ma.MachineID AS 'CloudZowID', '' AS 'Result'
	FROM Machine AS ma (NOLOCK)
	JOIN Member AS me ON ma.MemberID = me.MemberID
	WHERE me.Status = 2 AND me.Level = 0 AND me.GroupID <> 100
	AND ma.Status = 2 AND LiveDriveID > 0
	AND ma.ActiveDate <= @Todate
	ORDER BY ma.MachineID DESC
END

-- List all active computers for cancelled Resellers / Affiliates
IF @Status = 6
BEGIN
	SELECT ma.MachineID AS 'CloudZowID', '' AS 'Result'
	FROM Machine AS ma (NOLOCK)
	JOIN Member AS me ON ma.MemberID = me.MemberID
	WHERE me.Status > 5 AND me.Level = 1 AND me.GroupID <> 100
	AND ma.Status = 2 AND LiveDriveID > 0
	ORDER BY ma.MachineID DESC
END

GO

