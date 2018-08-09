EXEC [dbo].pts_CheckProc 'pts_Course_ListCourseCategory'
GO

CREATE PROCEDURE [dbo].pts_Course_ListCourseCategory
   @CourseCategoryID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      cs.CourseID, 
         cs.CourseName, 
         tr.CompanyName AS 'TrainerName', 
         cs.TrainerID, 
         cs.CourseLength, 
         cs.Rating, 
         cs.RatingCnt, 
         cs.Classes, 
         cs.Language, 
         cs.Description, 
         cs.Video, 
         cs.Audio, 
         cs.Quiz, 
         cs.CourseDate, 
         cs.Grp
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE (cs.CourseCategoryID = @CourseCategoryID)
 AND (cs.Status = 3)
 AND (cs.CompanyID = 0)

ORDER BY   cs.Grp , cs.Seq , cs.Rating DESC , cs.CourseName

GO