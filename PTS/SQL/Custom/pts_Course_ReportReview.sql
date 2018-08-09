EXEC [dbo].pts_CheckProc 'pts_Course_ReportReview'
GO

CREATE PROCEDURE [dbo].pts_Course_ReportReview
AS

SET NOCOUNT ON

SELECT 	co.CourseID 'CourseID',
	co.CourseName 'CourseName',
	tr.CompanyName 'TrainerName'
FROM Course AS co
LEFT JOIN Trainer AS tr ON co.TrainerID = tr.TrainerID
WHERE co.Status = 2
ORDER BY TrainerName

GO