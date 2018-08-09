EXEC [dbo].pts_CheckProc 'pts_GCR_LockPayouts'
GO

--declare @Result int EXEC pts_GCR_LockPayouts 1, @Result output

CREATE PROCEDURE [dbo].pts_GCR_LockPayouts
   @Option int, 
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @cnt int
SET @CompanyID = 17
SET @Result = '1'

-- *******************************************************************
-- Lock all Company Payout Methods
-- *******************************************************************
IF @Option = 1
BEGIN
	UPDATE bi SET Verified = 3
	FROM Billing AS bi
	JOIN Member AS me ON bi.BillingID = me.PayID
	WHERE me.CompanyID = @CompanyID AND Status = 1 
END

-- *******************************************************************
-- Unlock all Company Payout Methods
-- *******************************************************************
IF @Option = 2
BEGIN
	UPDATE bi SET Verified = 0
	FROM Billing AS bi
	JOIN Member AS me ON bi.BillingID = me.PayID
	WHERE me.CompanyID = @CompanyID AND Status = 1 
END


GO