EXEC [dbo].pts_CheckProc 'pts_Payment_LastBillingID'
GO

CREATE PROCEDURE [dbo].pts_Payment_LastBillingID
   @OwnerType int ,
   @OwnerID int ,
   @BillingID int OUTPUT 
AS

SET NOCOUNT ON

SELECT TOP 1 @BillingID = ISNULL(BillingID,0)
FROM Payment (NOLOCK)
WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID 
ORDER BY PayDate DESC

GO