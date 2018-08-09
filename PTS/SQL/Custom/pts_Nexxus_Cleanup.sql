EXEC [dbo].pts_CheckProc 'pts_Nexxus_Cleanup'
GO

-- EXEC pts_Nexxus_Cleanup

CREATE PROCEDURE [dbo].pts_Nexxus_Cleanup
AS

SET NOCOUNT ON
DECLARE @Today datetime, @Date datetime, @CompanyID int
SET @CompanyID = 21
SET @Today = dbo.wtfn_DateOnly( GETDATE())

-- Cancel all newly enrolled members over 3 days with no approved payment
SET @Date = DATEADD(d, -3, @Today )
--SELECT * 
UPDATE me SET Status = 6, EndDate = @Today
FROM Member AS me WHERE CompanyID = @CompanyID AND Status = 1 AND Billing = 3 AND Price > 0 AND EnrollDate < @Date 
AND 0 = (SELECT COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status = 3)

-- Turn off order option if they have 3 recent submitted or cancelled payments
--SELECT * 
UPDATE me SET Price = 0, Options2 = ''
FROM Member AS me WHERE CompanyID = @CompanyID AND Status = 1 AND Price > 0
AND 3 <= ( SELECT COUNT(*) FROM ( SELECT TOP 3 PaymentID FROM Payment WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status IN (1,6) ORDER BY PayDate DESC ) AS tmp )

-- Cancel all declined Payments over 7 days
SET @Date = DATEADD(d, -7, @Today )
UPDATE payment SET Status = 6 WHERE CompanyID = @CompanyID AND Status = 4 AND PayDate < @Date

-- Cancel all members suspended over 14 days
SET @Date = DATEADD(d, -14, @Today )
--SELECT * 
UPDATE me SET Status = 6, EndDate = @Today
FROM Member AS me WHERE CompanyID = @CompanyID AND Status = 4 AND EndDate < @Date

GO

