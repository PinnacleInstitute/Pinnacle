EXEC [dbo].pts_CheckProc 'pts_Goal_ReportCompany'
GO

--EXEC pts_Goal_ReportCompany 0, '1/1/2000', '1/1/06', 0, 0

CREATE PROCEDURE [dbo].pts_Goal_ReportCompany
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @GoalType int ,
   @Priority int 
AS

SET NOCOUNT ON

DECLARE @CompanyID int
SET @CompanyID = @MemberID
SELECT  
	MIN(tmp.MemberID) AS 'GoalID',
        tmp.CompanyName AS 'GoalName', 
        tmp.Role AS 'MemberName', 
	COUNT(*) AS 'Num1',
	SUM(tmp.Ontime) AS 'Num2',
	SUM(tmp.Late) AS 'Num3',
	AVG(tmp.Variance) AS 'Variance'
FROM (
	SELECT
        ma.CompanyName AS 'CompanyName', 
        me.Role AS 'Role', 
        me.MemberID AS 'MemberID', 
        ( 
		SELECT COUNT(*)
		FROM Goal as go
		WHERE go.MemberID = me.MemberID
		AND   go.CommitDate >= @FromDate
		AND   go.CommitDate <= @ToDate
		AND ( @GoalType = 0 OR go.GoalType = @GoalType )
		AND ( @Priority = 0 OR go.Priority = @Priority )
		AND go.Status = 3
		AND go.Variance <= 0
	) AS 'Ontime', 
        ( 
		SELECT COUNT(*)
		FROM Goal as go
		WHERE go.MemberID = me.MemberID
		AND   go.CommitDate >= @FromDate
		AND   go.CommitDate <= @ToDate
		AND ( @GoalType = 0 OR go.GoalType = @GoalType )
		AND ( @Priority = 0 OR go.Priority = @Priority )
		AND go.Status = 3
		AND go.Variance > 0
	) AS 'Late', 
        ( 
		SELECT AVG(Variance)
		FROM Goal as go
		WHERE go.MemberID = me.MemberID
		AND   go.CommitDate >= @FromDate
		AND   go.CommitDate <= @ToDate
		AND ( @GoalType = 0 OR go.GoalType = @GoalType )
		AND ( @Priority = 0 OR go.Priority = @Priority )
		AND go.Status = 3
	) AS 'Variance' 
	FROM Member as me
	LEFT OUTER JOIN Member AS ma ON me.MasterID = ma.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status <= 3 
)tmp
GROUP BY tmp.CompanyName, tmp.Role

GO
