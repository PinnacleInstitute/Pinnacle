EXEC [dbo].pts_CheckProc 'pts_Payout_CreatePayouts'
GO

--TEST---------------------------------------------------------
--DECLARE @Count int 
--EXEC pts_Payout_CreatePayouts @Count OUTPUT
--PRINT CAST(@Count AS VARCHAR)

CREATE PROCEDURE [dbo].pts_Payout_CreatePayouts
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @PayoutID int, @OwnerType int, @OwnerID int, @Amount money 
DECLARE @Now datetime

SET @Now = GETDATE()
SET @Count = 0

DECLARE Commission_cursor CURSOR LOCAL STATIC FOR 
SELECT OwnerType, OwnerID, SUM(Amount)
FROM Commission 
WHERE Status = 1
GROUP BY OwnerType, OwnerID

OPEN Commission_cursor
FETCH NEXT FROM Commission_cursor INTO @OwnerType, @OwnerID, @Amount

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Count = @Count + 1
	
--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, UserID
	EXEC pts_Payout_Add @PayoutID OUTPUT, 0, @OwnerType, @OwnerID, @Now, 0, @Amount, 1, '', 0, '', 1

	UPDATE Commission SET PayoutID = @PayoutID, Status = 2 
	WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID AND Status = 1

	FETCH NEXT FROM Commission_cursor INTO @OwnerType, @OwnerID, @Amount
END
CLOSE Commission_cursor
DEALLOCATE Commission_cursor

GO
