EXEC [dbo].pts_CheckProc 'pts_Course_ListPrivate'
GO

CREATE PROCEDURE [dbo].pts_Course_ListPrivate
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      cs.CourseID, 
         cs.TrainerID, 
         cs.CourseCategoryID, 
         tr.CompanyName AS 'TrainerName', 
         cs.TrainerID, 
         cs.CourseName, 
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
LEFT OUTER JOIN CourseCategory AS cc (NOLOCK) ON (cs.CourseCategoryID = cc.CourseCategoryID)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE (cs.CompanyID = @CompanyID)
 AND (cs.Status = 3)

ORDER BY   cs.Grp , cs.Seq , cs.CourseName

GO