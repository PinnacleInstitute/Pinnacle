EXEC [dbo].pts_CheckProc 'pts_Payment_ListOwnerStatus'
GO

--EXEC pts_Payment_ListOwnerStatus 4,  37709, 1
--EXEC pts_Payment_ListOwnerStatus 4, 22795, 2
 
CREATE PROCEDURE [dbo].pts_Payment_ListOwnerStatus
   @OwnerType int ,
   @OwnerID int ,
   @Status int
AS

SET NOCOUNT ON

-- Get Member Submitted Payments
IF @Status = 1
BEGIN
	SELECT   pa.PaymentID, pa.PayDate, pa.Amount, pa.Total, pa.Credit, pa.Status, pa.PayType, pa.Reference, pa.Description, pa.Purpose 'Notes'
	FROM Payment AS pa (NOLOCK)
	WHERE (pa.OwnerType = @OwnerType) AND (pa.OwnerID = @OwnerID) AND (pa.Status IN (1,4) )
	ORDER BY   pa.PayDate DESC
END
-- Get SalesOrder Submitted Payments
IF @Status = 2
BEGIN
	SELECT   pa.PaymentID, pa.PayDate, pa.Amount, pa.Total, pa.Credit, pa.Status, pa.PayType, pa.Reference, pa.Description, pa.Notes
	FROM Payment AS pa (NOLOCK)
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	WHERE (so.MemberID = @OwnerID) AND (pa.Status = 1)
	ORDER BY pa.PayDate DESC
END

GO