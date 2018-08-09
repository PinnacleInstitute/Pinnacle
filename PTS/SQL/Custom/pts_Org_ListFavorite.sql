EXEC [dbo].pts_CheckProc 'pts_Org_ListFavorite'
GO

CREATE PROCEDURE [dbo].pts_Org_ListFavorite
   @MemberID int ,
   @CourseDate datetime ,
   @Status int
AS

SET NOCOUNT ON

--Get All Favorite Company Folders
IF @Status = 28
BEGIN
	SELECT org.OrgID, 
	       org.OrgName, 
	       COUNT(*) AS 'CourseCount'
	FROM   OrgCourse AS oco
	JOIN   Course AS co ON (co.CourseID = oco.CourseID)
	JOIN   Org AS org ON (org.OrgID = oco.OrgID)
	JOIN   Favorite AS f ON (f.RefID = oco.OrgID AND f.RefType = 2)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID
	GROUP BY org.OrgID, org.OrgName
END

--Get All Favorite Company Folders with new courses
IF @Status = 32 OR @Status = 33
BEGIN
	SELECT org.OrgID, 
	       org.OrgName, 
	       COUNT(*) AS 'CourseCount'
	FROM   OrgCourse AS oco
	JOIN   Course AS co ON (co.CourseID = oco.CourseID)
	JOIN   Org AS org ON (org.OrgID = oco.OrgID)
	JOIN   Favorite AS f ON (f.RefID = oco.OrgID AND f.RefType = 2)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID AND co.CourseDate > @CourseDate
	GROUP BY org.OrgID, org.OrgName
END

GO