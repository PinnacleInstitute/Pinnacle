EXEC [dbo].pts_CheckProc 'pts_Expense_Update'
GO

CREATE PROCEDURE [dbo].pts_Expense_Update
   @ExpenseID int,
   @MemberID int,
   @ExpenseTypeID int,
   @ExpType int,
   @ExpDate datetime,
   @Total money,
   @Amount money,
   @MilesStart int,
   @MilesEnd int,
   @TotalMiles int,
   @Note1 nvarchar (50),
   @Note2 nvarchar (100),
   @Purpose nvarchar (200),
   @UserID int
AS

SET NOCOUNT ON

UPDATE ex
SET ex.MemberID = @MemberID ,
   ex.ExpenseTypeID = @ExpenseTypeID ,
   ex.ExpType = @ExpType ,
   ex.ExpDate = @ExpDate ,
   ex.Total = @Total ,
   ex.Amount = @Amount ,
   ex.MilesStart = @MilesStart ,
   ex.MilesEnd = @MilesEnd ,
   ex.TotalMiles = @TotalMiles ,
   ex.Note1 = @Note1 ,
   ex.Note2 = @Note2 ,
   ex.Purpose = @Purpose
FROM Expense AS ex
WHERE (ex.ExpenseID = @ExpenseID)


EXEC pts_Expense_CalcTotal
   @ExpenseID

GO