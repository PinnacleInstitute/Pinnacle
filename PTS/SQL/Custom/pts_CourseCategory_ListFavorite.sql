EXEC [dbo].pts_CheckProc 'pts_CourseCategory_ListFavorite'
GO

CREATE PROCEDURE [dbo].pts_CourseCategory_ListFavorite
   @MemberID int ,
   @CourseDate datetime ,
   @Seq int
AS

SET NOCOUNT ON

--Get All Favorite Public Folders
IF @Seq = 29
BEGIN
	SELECT   cc.CourseCategoryID, 
	         cc.CourseCategoryName, 
	         COUNT(*) AS 'CourseCount'
	FROM   Course AS co
	JOIN   CourseCategory AS cc ON (co.CourseCategoryID = cc.CourseCategoryID)
	JOIN   Favorite AS f ON (f.RefID = cc.CourseCategoryID AND f.RefType = 1)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID
	GROUP BY cc.CourseCategoryID, cc.CourseCategoryName
END

--Get All Favorite Public Folders with new courses
IF @Seq = 34 OR @Seq = 35
BEGIN
	SELECT   cc.CourseCategoryID, 
	         cc.CourseCategoryName, 
	         COUNT(*) AS 'CourseCount'
	FROM   Course AS co
	JOIN   CourseCategory AS cc ON (co.CourseCategoryID = cc.CourseCategoryID)
	JOIN   Favorite AS f ON (f.RefID = cc.CourseCategoryID AND f.RefType = 1)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID AND co.CourseDate > @CourseDate
	GROUP BY cc.CourseCategoryID, cc.CourseCategoryName
END

GO