EXEC [dbo].pts_CheckProc 'pts_Course_TBCompanyDate'
 GO

CREATE PROCEDURE [dbo].pts_Course_TBCompanyDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @TrainerID int,
   @CourseDate datetime
      )
AS

SET NOCOUNT ON

DECLARE @MemberID int
SET @MemberID = @TrainerID

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'

SELECT DISTINCT TOP 21
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
FROM (
	SELECT Org.OrgID
	FROM Org
	LEFT OUTER JOIN (
		SELECT Org.OrgID, Org.Hierarchy
		FROM OrgMember
		JOIN Org ON (OrgMember.OrgID = Org.OrgID)
		WHERE Org.PrivateID = Org.OrgID
		AND OrgMember.MemberID = @MemberID
	) AS private ON (private.OrgID = Org.PrivateID)
	WHERE Org.CompanyID = @CompanyID
	AND (Org.Status = 2 OR Org.Status = 3)
	AND (Org.PrivateID = 0 OR Org.Hierarchy LIKE private.Hierarchy + '%')
) AS tmp
LEFT  OUTER JOIN OrgCourse AS oco ON (oco.OrgID = tmp.OrgID)
LEFT  OUTER JOIN Course AS cs ON (cs.CourseID = oco.CourseID)
LEFT  OUTER JOIN Trainer AS tr (NOLOCK) ON (cs.TrainerID = tr.TrainerID)
WHERE cs.Status = 3 AND cs.CourseDate > @CourseDate
AND ISNULL(CONVERT(nvarchar(10), cs.CourseDate, 112), '') + dbo.wtfn_FormatNumber(cs.CourseID, 10) <= @BookMark

ORDER BY 'Bookmark' DESC

GO