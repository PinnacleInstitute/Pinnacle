EXEC [dbo].pts_CheckProc 'pts_Course_ListOrg'
 GO

CREATE PROCEDURE [dbo].pts_Course_ListOrg ( 
	@OrgID int
      )
AS

SET         NOCOUNT ON

SELECT DISTINCT co.CourseID, 
	co.CourseName, 
	tr.CompanyName AS 'TrainerName', 
	co.TrainerID, 
	co.CourseLength, 
	co.CourseType, 
	co.CourseLevel,
	co.Status,
 	co.Rating,
   co.RatingCnt,
   co.Classes,
	co.Language,
	co.Description,
	co.Video,
	co.Audio,
	co.Quiz,
	co.Grp,
	og.OrgCourseID AS 'OrgCourseID',
	og.Status AS 'OrgStatus', 
	og.Seq AS 'OrgSeq'
FROM OrgCourse AS og
LEFT OUTER JOIN Course AS co ON (co.CourseID = og.CourseID)
LEFT OUTER JOIN Trainer AS tr ON (tr.TrainerID = co.TrainerID)
WHERE (og.OrgID = @OrgID AND co.Status = 3)
ORDER BY og.Seq, og.Status DESC, co.Rating DESC, co.CourseName

GO