EXEC [dbo].pts_CheckProc 'pts_Course_ListProgram'
GO

--EXEC pts_Course_ListProgram 547, 0

CREATE PROCEDURE [dbo].pts_Course_ListProgram
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
        cs.Grp,
	cs.Credit,
        oc.Status
FROM    Course AS cs (NOLOCK)
JOIN	OrgCourse as oc ON cs.CourseID = oc.CourseID
WHERE   oc.OrgID = @OrgID
ORDER BY oc.Seq

GO
