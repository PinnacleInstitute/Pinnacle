EXEC [dbo].pts_CheckProc 'pts_SalesOrder_UpdateRecurring'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_UpdateRecurring
   @OrderDate datetime ,
   @SalesOrderID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @SalesItemID int, @BillDate datetime, @EndDate datetime, @Recur int, @tmpDate datetime
SET @Result = 0

DECLARE SalesItem_cursor CURSOR LOCAL FOR 
SELECT si.SalesItemID, si.BillDate, si.EndDate, pr.recur 
FROM SalesItem AS si
JOIN Product AS pr ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID
AND pr.recur > 0
AND si.BillDate > 0
AND si.BillDate <= @OrderDate

OPEN SalesItem_cursor

FETCH NEXT FROM SalesItem_cursor INTO @SalesItemID, @BillDate, @EndDate, @Recur

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Result = @Result + 1

	IF @Recur = 1
		SET @tmpDate = DATEADD(m, 1, @BillDate)
	ELSE
		SET @tmpDate = DATEADD(ww, 1, @BillDate)

	IF @EndDate > 0
	BEGIN
		IF DATEDIFF(day, @tmpDate, @EndDate) < 0
			SET @tmpDate = 0
	END

	UPDATE SalesItem SET BillDate = @tmpDate WHERE SalesItemID = @SalesItemID
	
	FETCH NEXT FROM SalesItem_cursor INTO @SalesItemID, @BillDate, @EndDate, @Recur
END

CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor

IF @Result = 0 
	UPDATE SalesOrder SET IsRecur = 0 WHERE SalesOrderID = @SalesOrderID
Else
	UPDATE SalesOrder SET IsRecur = 1 WHERE SalesOrderID = @SalesOrderID

GO