EXEC [dbo].pts_CheckProc 'pts_Expense_CalcTotal'
GO

CREATE PROCEDURE [dbo].pts_Expense_CalcTotal
   @ExpenseID int
AS

SET NOCOUNT ON

DECLARE @Year int, @ExpType int, @Amount money, @MemberID int 
DECLARE @TotalMiles int, @MilesStart int, @MilesEnd int, @TaxType int 

SELECT @Year = YEAR(ex.ExpDate), @ExpType = ex.ExpType, @Amount = ex.Amount, @MemberID = ex.MemberID, 
	@TotalMiles = ex.TotalMiles, @MilesStart = ex.MilesStart, @MilesEnd = ex.MilesEnd, @TaxType = ext.TaxType
FROM Expense AS ex
LEFT OUTER JOIN ExpenseType AS ext ON ex.ExpenseTypeID = ext.ExpenseTypeID
WHERE ExpenseID = @ExpenseID

EXEC pts_Expense_Calc @ExpenseID, @Year, @ExpType, @Amount, @MemberID, @TotalMiles, @MilesStart, @MilesEnd, @TaxType

GO