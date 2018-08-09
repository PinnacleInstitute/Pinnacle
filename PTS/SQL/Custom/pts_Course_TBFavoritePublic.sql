EXEC [dbo].pts_CheckProc 'pts_Course_TBFavoritePublic'
 GO

CREATE PROCEDURE [dbo].pts_Course_TBFavoritePublic ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @TrainerID int ,
   @CourseDate datetime
      )
AS

SET NOCOUNT ON

DECLARE @MemberID int
SET @MemberID = @TrainerID

SET @MaxRows = 20

SELECT DISTINCT TOP 21
	ISNULL(CourseName, '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) 'BookMark' ,
	cs.CourseID,
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
FROM   Course AS cs
JOIN   Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
JOIN   CourseCategory AS cc ON (cs.CourseCategoryID = cc.CourseCategoryID)
JOIN   Favorite AS f ON (f.RefID = cc.CourseCategoryID AND f.RefType = 1)
WHERE  cs.Status = 3 AND f.MemberID = @MemberID AND cs.CourseDate > @CourseDate
AND ISNULL(CourseName, '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) >= @BookMark

ORDER BY 'Bookmark' 

GO