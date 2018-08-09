EXEC [dbo].pts_CheckProc 'pts_Expense_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Expense_Delete ( 
   @ExpenseID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ex
FROM Expense AS ex
WHERE ex.ExpenseID = @ExpenseID

GO