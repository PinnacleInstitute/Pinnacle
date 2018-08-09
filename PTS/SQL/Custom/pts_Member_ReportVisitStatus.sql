EXEC [dbo].pts_CheckProc 'pts_Member_ReportVisitStatus'
GO

CREATE PROCEDURE [dbo].pts_Member_ReportVisitStatus
   @CompanyID int,
   @Status int
AS

SET NOCOUNT ON

SELECT 	me.Amount AS 'MemberID' ,
	me.Amount AS 'Amount',
	COUNT(*) AS 'Quantity' 
FROM (
	SELECT
		MemberID,
		CASE  
		WHEN VisitDate = 0 THEN 32
		WHEN DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) <= 1 THEN 1
		WHEN DATEDIFF(dd, VisitDate, CURRENT_TIMESTAMP) <= 3 THEN 3
		WHEN DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) <= 1 THEN 7
		WHEN DATEDIFF(wk, VisitDate, CURRENT_TIMESTAMP) <= 2 THEN 14
		WHEN DATEDIFF(m, VisitDate, CURRENT_TIMESTAMP) <= 1 THEN 30
		ELSE 31
		END AS 'Amount'
	FROM 	Member
	WHERE	(@CompanyID = 0 OR CompanyID = @CompanyID)
	AND   Status = @Status 
	) AS me
GROUP BY me.Amount
ORDER BY me.Amount

GO