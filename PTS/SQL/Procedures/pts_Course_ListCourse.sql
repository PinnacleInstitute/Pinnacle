EXEC [dbo].pts_CheckProc 'pts_Course_ListCourse'
GO

CREATE PROCEDURE [dbo].pts_Course_ListCourse
   @CourseCategoryID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      cs.CourseID, 
         cs.TrainerID, 
         cs.CourseCategoryID, 
         tr.CompanyName AS 'TrainerName', 
         cs.CourseName, 
         cs.CourseLength, 
         cs.Video, 
         cs.Audio, 
         cs.Quiz
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN CourseCategory AS cc (NOLOCK) ON (cs.CourseCategoryID = cc.CourseCategoryID)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE (cs.CourseCategoryID = @CourseCategoryID)
 AND (cs.CompanyID = 0)

ORDER BY   cs.CourseName

GO