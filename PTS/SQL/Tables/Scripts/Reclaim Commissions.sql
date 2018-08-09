-- **************************************
-- Reclaim Commissions
-- **************************************
declare @PaymentID int, @cnt int

DECLARE Payment_cursor CURSOR FOR 
SELECT PaymentID FROM Payment WHERE Status = 5 AND CommStatus = 2

OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @PaymentID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_CloudZow_Reclaim @PaymentID, @cnt OUTPUT
	FETCH NEXT FROM Payment_cursor INTO @PaymentID
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor

