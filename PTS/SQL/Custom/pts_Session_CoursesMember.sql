EXEC [dbo].pts_CheckProc 'pts_Session_CoursesMember'
GO

--EXEC pts_Session_CoursesMember 84, '1/1/2000', '1/1/06'

CREATE PROCEDURE [dbo].pts_Session_CoursesMember
   @MemberID int ,
   @StartDate datetime ,
   @CompleteDate datetime 
AS

SET NOCOUNT ON

SELECT se.SessionID, 
	   se.CourseID,
       co.CourseName AS 'CourseName', 
       se.CompleteDate, 
       se.Grade, 
       co.PassingGrade AS 'Num1', 
       se.Status
FROM Session as se
JOIN Course AS co ON se.CourseID = co.CourseID 
WHERE se.MemberID = @MemberID
AND se.CompleteDate >= @StartDate
AND se.CompleteDate <= @CompleteDate
ORDER BY se.CompleteDate
GO