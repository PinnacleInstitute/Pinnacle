EXEC [dbo].pts_CheckProc 'pts_Course_ListFavorite'
GO

CREATE PROCEDURE [dbo].pts_Course_ListFavorite
   @OrgID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT  cs.CourseID, 
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
FROM    Course AS cs (NOLOCK)
JOIN	OrgCourse as oc ON cs.CourseID = oc.CourseID
WHERE   oc.OrgID = @OrgID
ORDER BY cs.Rating DESC , cs.CourseName

GO
