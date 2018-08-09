EXEC [dbo].pts_CheckProc 'pts_Course_ReportStatus'
GO

CREATE PROCEDURE [dbo].pts_Course_ReportStatus
AS

SET         NOCOUNT ON

SELECT 	Status AS 'CourseID', 
	Status AS 'Status', 
	COUNT(*) AS 'Quantity' 
FROM 	Course 
GROUP BY Status
ORDER BY Status

GO