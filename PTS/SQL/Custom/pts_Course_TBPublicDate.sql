EXEC [dbo].pts_CheckProc 'pts_Course_TBPublicDate'
 GO

CREATE PROCEDURE [dbo].pts_Course_TBPublicDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CourseDate datetime
      )
AS

SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'

SELECT TOP 21
	ISNULL(CONVERT(nvarchar(10), cs.CourseDate, 112), '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) 'BookMark' ,
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
FROM Course AS cs (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE cs.CourseDate > @CourseDate
AND ISNULL(CONVERT(nvarchar(10), cs.CourseDate, 112), '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) <= @BookMark
AND cs.Status = 3 AND cs.CompanyID = 0
ORDER BY 'Bookmark' DESC

GO