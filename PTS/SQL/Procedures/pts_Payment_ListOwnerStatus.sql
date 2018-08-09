EXEC [dbo].pts_CheckProc 'pts_Payment_ListOwnerStatus'
GO

CREATE PROCEDURE [dbo].pts_Payment_ListOwnerStatus
   @OwnerType int ,
   @OwnerID int ,
   @Status int
AS

SET NOCOUNT ON

SELECT      pa.PaymentID, 
         pa.PayDate, 
         pa.Amount, 
         pa.Total, 
         pa.Credit, 
         pa.Status, 
         pa.PayType, 
         pa.Reference, 
         pa.Description, 
         pa.Notes
FROM Payment AS pa (NOLOCK)
WHERE (pa.OwnerType = @OwnerType)
 AND (pa.OwnerID = @OwnerID)
 AND (pa.Status = @Status)

ORDER BY   pa.PayDate DESC

GO