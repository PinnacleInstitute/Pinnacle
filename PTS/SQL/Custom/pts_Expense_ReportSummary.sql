EXEC [dbo].pts_CheckProc 'pts_Expense_ReportSummary'
GO

--EXEC pts_Expense_ReportSummary 84, '1/1/2009', '1/1/2010'

CREATE PROCEDURE [dbo].pts_Expense_ReportSummary
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT   MIN(ex.ExpenseID) AS 'ExpenseID', 
         ex.ExpType AS 'ExpType', 
         SUM(ex.Amount) AS 'Amount', 
         SUM(ex.Total) AS 'Total'
FROM Expense AS ex (NOLOCK)
LEFT OUTER JOIN ExpenseType AS ext (NOLOCK) ON (ex.ExpenseTypeID = ext.ExpenseTypeID)
WHERE (ex.MemberID = @MemberID)
AND ex.ExpDate >= @FromDate
AND ex.ExpDate <= @ToDate
GROUP BY ex.ExpType
ORDER BY ex.ExpType

GO