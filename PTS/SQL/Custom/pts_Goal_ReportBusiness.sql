EXEC [dbo].pts_CheckProc 'pts_Goal_ReportBusiness'
GO

--EXEC pts_Goal_ReportBusiness 0, '1/1/2000', '1/1/06', 0, 0

CREATE PROCEDURE [dbo].pts_Goal_ReportBusiness
   @MemberID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @GoalType int ,
   @Priority int 
AS

SET NOCOUNT ON

DECLARE @MasterID int
SET @MasterID = @MemberID

SELECT  
	MIN(tmp.MemberID) AS 'GoalID',
        tmp.GroupID AS 'GoalName', 
        tmp.Role AS 'MemberName', 
	COUNT(*) AS 'Num1',
	SUM(tmp.Ontime) AS 'Num2',
	SUM(tmp.Late) AS 'Num3',
	AVG(tmp.Variance) AS 'Variance'
FROM (
	SELECT
        me.GroupID AS 'GroupID', 
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
	WHERE me.MasterID = @MasterID AND me.Status <= 3 
)tmp
GROUP BY tmp.GroupID, tmp.Role

GO
