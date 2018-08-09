EXEC [dbo].pts_CheckProc 'pts_Course_Search'
 GO

CREATE PROCEDURE [dbo].pts_Course_Search ( 
      @SearchText nvarchar (200),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT,
      @CompanyID int
      )
AS

SET            NOCOUNT ON

SET            @MaxRows = 20

IF @Bookmark = '' 
	SET @Bookmark = '9999'

SELECT TOP 21
	dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(cs.CourseID, 10) 'BookMark' ,
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
FROM Course AS cs
INNER JOIN CONTAINSTABLE(CourseFT,*, @SearchText, 1000 ) AS K ON cs.CourseID = K.[KEY]
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(cs.CourseID, 10) <= @Bookmark
AND cs.Status = 3
AND ( cs.CompanyID = 0 OR cs.CompanyID = @CompanyID )
ORDER BY 'Bookmark' desc 

GO