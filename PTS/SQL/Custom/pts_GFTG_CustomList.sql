EXEC [dbo].pts_CheckProc 'pts_GFTG_CustomList'
GO

-- EXEC pts_GFTG_CustomList 3, 0, 0, 0

CREATE PROCEDURE [dbo].pts_GFTG_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Today datetime, @ToDate datetime
SET @CompanyID = 13
SET @Today = dbo.wtfn_DateOnly(GETDATE())

-- List all new iPayout eWallets to create
IF @Status = 3
BEGIN
--UserName,FirstName,LastName,CompanyName,Address1,Address2,City,State,ZipCode,Country2xFormat,PhoneNumber,CellPhoneNumber,EmailAddress,SSN,CompanyTaxID,GovernmentID,MilitaryID,PassportNumber,DriversLicense,DateOfBirth,WebsitePassword,DefaultCurrency,PreferredLanguage
	SELECT me.MemberID AS 'GFTGID', '"' + au.Logon + '","' + me.NameFirst + '","' + me.NameLast + '",,,,,,,,,,"' + me.Email + '",,,,,,,,"' + au.Password + '",,' AS 'Result'
	FROM Member AS me
	JOIN Billing AS bi ON me.PayID = bi.BillingID
	JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
	WHERE CompanyID = @CompanyID AND me.Status = 1 AND me.Level = 1
	AND bi.CardType = 11 AND bi.CardName = ''
	order by me.NameLast, me.namefirst
END

GO

