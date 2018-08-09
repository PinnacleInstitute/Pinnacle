EXEC [dbo].pts_CheckProc 'pts_Expense_ReportDetail'
GO

--EXEC pts_Expense_ReportDetail 84, 1, '1/1/2009', '1/1/2010'

CREATE PROCEDURE [dbo].pts_Expense_ReportDetail
   @MemberID int ,
   @ExpType int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT   ex.ExpenseID, 
         ex.ExpDate, 
         ext.ExpenseTypeName AS 'ExpenseTypeName', 
         ex.Amount, 
         ex.Total, 
         ex.MilesStart, 
         ex.MilesEnd, 
         ex.TotalMiles, 
         ex.Note1, 
         ex.Note2, 
         ex.Purpose
FROM Expense AS ex (NOLOCK)
LEFT OUTER JOIN ExpenseType AS ext (NOLOCK) ON (ex.ExpenseTypeID = ext.ExpenseTypeID)
WHERE (ex.MemberID = @MemberID)
AND (@ExpType = -1 OR ex.ExpType = @ExpType)
AND ex.ExpDate >= @FromDate
AND ex.ExpDate <= @ToDate
ORDER BY   ex.ExpDate, ex.ExpType, ex.Amount DESC

GO