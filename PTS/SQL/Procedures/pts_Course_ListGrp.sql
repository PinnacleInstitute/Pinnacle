EXEC [dbo].pts_CheckProc 'pts_Course_ListGrp'
GO

CREATE PROCEDURE [dbo].pts_Course_ListGrp
   @Grp int
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
         cs.CourseDate
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE (cs.Grp = @Grp)
 AND (cs.Status = 3)

ORDER BY   cs.Seq

GO