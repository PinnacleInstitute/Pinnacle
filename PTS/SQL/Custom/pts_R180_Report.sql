EXEC [dbo].pts_CheckProc 'pts_R180_Report'
GO

-- EXEC pts_R180_Report 13, '7/1/14', 5, 0

CREATE PROCEDURE [dbo].pts_R180_Report
   @Status int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Today datetime, @FromDate datetime, @ToDate datetime
SET @CompanyID = 12
SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- List Member Ads
IF @Status = 1
BEGIN
--UserName,FirstName,LastName,CompanyName,Address1,Address2,City,State,ZipCode,Country2xFormat,PhoneNumber,CellPhoneNumber,EmailAddress,SSN,CompanyTaxID,GovernmentID,MilitaryID,PassportNumber,DriversLicense,DateOfBirth,WebsitePassword,DefaultCurrency,PreferredLanguage
	SELECT me.MemberID AS 'LegacyID', '"' + au.Logon + '","' + me.NameFirst + '","' + me.NameLast + '",,,,,,,,,,"' + me.Email + '",,,,,,,,"' + au.Password + '",,' AS 'Result'
	FROM Member AS me
	JOIN Billing AS bi ON me.PayID = bi.BillingID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 1
	AND bi.CardType = 11 AND bi.CardName = ''
	order by me.NameLast, me.namefirst
END


GO

