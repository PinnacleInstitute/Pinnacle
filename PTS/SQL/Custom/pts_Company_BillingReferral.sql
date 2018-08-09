EXEC [dbo].pts_CheckProc 'pts_Company_BillingReferral'
GO

CREATE PROCEDURE [dbo].pts_Company_BillingReferral
   @MemberID int,
   @Count int OUTPUT,
   @Referrals nvarchar(500) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Reference nvarchar(15)

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT Reference FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Billing > 1

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @Reference

SET @Count = 0
SET @Referrals = ''

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Count = @Count + 1
	SET @Referrals = @Referrals + @Reference + ' '
	FETCH NEXT FROM Member_cursor INTO @Reference
END
IF @Count > 0 SET @Referrals = 'Credit:[' + @Referrals + '] '

CLOSE Member_cursor
DEALLOCATE Member_cursor

GO