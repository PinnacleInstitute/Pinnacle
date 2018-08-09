EXEC [dbo].pts_CheckProc 'pts_Payment_CompanyDebits'
GO

CREATE PROCEDURE [dbo].pts_Payment_CompanyDebits
   @CompanyID int ,
   @PayDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON
SET @Count = 0

DECLARE @MemberID int, @PayoutID int, @Total money, @Cnt int

-- Get all unpaid payouts for each member
DECLARE Payout_cursor CURSOR LOCAL STATIC FOR 
SELECT po.OwnerID, po.PayoutID, po.Amount
FROM Payout AS po (NOLOCK)
WHERE po.CompanyID = @CompanyID AND po.OwnerType = 4 AND po.Status = 1

OPEN Payout_cursor
FETCH NEXT FROM Payout_cursor INTO @MemberID, @PayoutID, @Total

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Cnt = 0
	EXEC pts_Payment_CompanyDebit @CompanyID, @PayDate, @MemberID, @PayoutID, @Total, @Cnt OUTPUT
	SET @Count = @Count + @Cnt
	FETCH NEXT FROM Payout_cursor INTO @MemberID, @PayoutID, @Total
END

CLOSE Payout_cursor
DEALLOCATE Payout_cursor

GO