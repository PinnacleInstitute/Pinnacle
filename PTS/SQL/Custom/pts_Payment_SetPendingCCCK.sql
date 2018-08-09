EXEC [dbo].pts_CheckProc 'pts_Payment_SetPendingCCCK'
GO

CREATE PROCEDURE [dbo].pts_Payment_SetPendingCCCK
   @Count int OUTPUT 
AS

SET NOCOUNT ON

DECLARE @Today datetime
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

SET @Count = 0
SELECT @Count = COUNT(*) FROM Payment WHERE Status = 1 AND PayType >= 1 AND PayType <= 5 AND OwnerType <> 52

UPDATE Payment SET Status = 2, PaidDate = @Today WHERE Status = 1 AND PayType >= 1 AND PayType <= 5 AND OwnerType <> 52

GO