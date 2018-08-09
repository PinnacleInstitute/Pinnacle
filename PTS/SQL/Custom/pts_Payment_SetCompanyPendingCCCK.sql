EXEC [dbo].pts_CheckProc 'pts_Payment_SetCompanyPendingCCCK'
GO

CREATE PROCEDURE [dbo].pts_Payment_SetCompanyPendingCCCK
   @CompanyID int , 
   @Count int OUTPUT 
AS

SET NOCOUNT ON

DECLARE @Today datetime
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

SET @Count = 0
SELECT @Count = COUNT(*)
FROM Payment AS pa
JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND pa.Status = 1 AND pa.PayType >= 1 AND pa.PayType <= 5

UPDATE pa SET Status = 2, PaidDate = @Today 
FROM Payment AS pa
JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
WHERE me.CompanyID = @CompanyID AND pa.Status = 1 AND pa.PayType >= 1 AND pa.PayType <= 5

GO