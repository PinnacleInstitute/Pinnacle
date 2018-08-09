EXEC [dbo].pts_CheckProc 'pts_Expense_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Expense_Fetch ( 
   @ExpenseID int,
   @MemberID int OUTPUT,
   @ExpenseTypeID int OUTPUT,
   @ExpenseTypeName nvarchar (40) OUTPUT,
   @TaxType int OUTPUT,
   @IsRequired bit OUTPUT,
   @ExpType int OUTPUT,
   @ExpDate datetime OUTPUT,
   @Total money OUTPUT,
   @Amount money OUTPUT,
   @MilesStart int OUTPUT,
   @MilesEnd int OUTPUT,
   @TotalMiles int OUTPUT,
   @Note1 nvarchar (50) OUTPUT,
   @Note2 nvarchar (100) OUTPUT,
   @Purpose nvarchar (200) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ex.MemberID ,
   @ExpenseTypeID = ex.ExpenseTypeID ,
   @ExpenseTypeName = ext.ExpenseTypeName ,
   @TaxType = ext.TaxType ,
   @IsRequired = ext.IsRequired ,
   @ExpType = ex.ExpType ,
   @ExpDate = ex.ExpDate ,
   @Total = ex.Total ,
   @Amount = ex.Amount ,
   @MilesStart = ex.MilesStart ,
   @MilesEnd = ex.MilesEnd ,
   @TotalMiles = ex.TotalMiles ,
   @Note1 = ex.Note1 ,
   @Note2 = ex.Note2 ,
   @Purpose = ex.Purpose
FROM Expense AS ex (NOLOCK)
LEFT OUTER JOIN ExpenseType AS ext (NOLOCK) ON (ex.ExpenseTypeID = ext.ExpenseTypeID)
WHERE ex.ExpenseID = @ExpenseID

GO