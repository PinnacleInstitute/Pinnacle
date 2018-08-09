EXEC [dbo].pts_CheckProc 'pts_Session_CoursesBusiness'
GO

--EXEC pts_Session_CoursesBusiness 84, '1/1/2000', '1/1/06', 38

CREATE PROCEDURE [dbo].pts_Session_CoursesBusiness
   @MemberID int ,
   @StartDate datetime ,
   @CompleteDate datetime ,
   @CourseID int
AS

SET NOCOUNT ON

DECLARE @MasterID int
SET @MasterID = @MemberID

SELECT  
	MIN(tmp.MemberID) AS 'SessionID',
        tmp.GroupID AS 'CourseName', 
        tmp.Role AS 'MemberName', 
	COUNT(*) AS 'Num1',
	SUM(tmp.Taken) AS 'Num2',
	SUM(tmp.Passed) AS 'Num3'
FROM (
	SELECT
        me.GroupID AS 'GroupID', 
        me.Role AS 'Role', 
        me.MemberID AS 'MemberID', 
        ( 
		SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
		FROM Session as se
		WHERE se.MemberID = me.MemberID
		AND se.CourseID = @CourseID
		AND se.CompleteDate >= @StartDate
		AND se.CompleteDate <= @CompleteDate
	) AS 'Taken', 
        ( 
		SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
		FROM Session as se
		WHERE se.MemberID = me.MemberID
		AND se.CourseID = @CourseID
		AND se.CompleteDate >= @StartDate
		AND se.CompleteDate <= @CompleteDate
		AND se.Status = 7
	) AS 'Passed' 
	FROM Member as me
	WHERE me.MasterID = @MasterID AND me.Status <= 3 
)tmp
GROUP BY tmp.GroupID, tmp.Role
ORDER BY tmp.GroupID, tmp.Role

GO
