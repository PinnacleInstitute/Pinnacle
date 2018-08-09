EXEC [dbo].pts_CheckProc 'pts_MemberTax_Recalc'
GO

--DECLARE @Result int 
--EXEC pts_MemberTax_Recalc 84, 2009, @Result OUTPUT 
--PRINT @Result

CREATE PROCEDURE [dbo].pts_MemberTax_Recalc
   @MemberID int ,
   @Year int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON


DECLARE @ExpenseID int, @ExpType int, @Amount money 
DECLARE @TotalMiles int, @MilesStart int, @MilesEnd int, @TaxType int 
DECLARE @cnt int
-- ************************************************************************************
-- get all expenses for the specified year that are calculated (vs. direct)
-- ************************************************************************************
DECLARE Expense_Cursor CURSOR LOCAL STATIC FOR 
SELECT  ex.ExpenseID, ex.ExpType, ex.Amount, ex.TotalMiles, ex.MilesStart, ex.MilesEnd, ext.TaxType
FROM Expense AS ex
LEFT OUTER JOIN ExpenseType AS ext ON ex.ExpenseTypeID = ext.ExpenseTypeID
WHERE ex.MemberID = @MemberID
AND YEAR(ex.ExpDate) = @Year
AND ext.TaxType <> 0

OPEN Expense_Cursor
FETCH NEXT FROM Expense_Cursor INTO @ExpenseID, @ExpType, @Amount, @TotalMiles, @MilesStart, @MilesEnd, @TaxType

SET @cnt = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Expense_Calc @ExpenseID, @Year, @ExpType, @Amount, @MemberID, @TotalMiles, @MilesStart, @MilesEnd, @TaxType
	SET @cnt = @cnt + 1
	FETCH NEXT FROM Expense_Cursor INTO @ExpenseID, @ExpType, @Amount, @TotalMiles, @MilesStart, @MilesEnd, @TaxType
END
CLOSE Expense_Cursor
DEALLOCATE Expense_Cursor

SET @Result = @cnt

GO