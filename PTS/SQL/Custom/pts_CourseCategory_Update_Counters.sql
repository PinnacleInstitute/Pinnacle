EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Update_Counters'
GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Update_Counters
   @CourseCategoryID int
AS

DECLARE @cnt int

SET NOCOUNT ON

WHILE @CourseCategoryID > 0
BEGIN
--	Get the total number of active courses in the sub categories
	SELECT @cnt = ISNULL(SUM(CourseCount),0) FROM CourseCategory WHERE ParentCategoryID = @CourseCategoryID
--	Get the total number of active courses in the specified category
	SELECT @cnt = @cnt + ISNULL(COUNT(CourseID),0) FROM Course WHERE CourseCategoryID = @CourseCategoryID AND Status = 3
--	Update the total number of active courses in the specified category
	UPDATE CourseCategory SET CourseCount = @cnt WHERE CourseCategoryID = @CourseCategoryID

--	Get the parent category of the specified category and process it
	IF 0 < ( SELECT COUNT(*) FROM CourseCategory WHERE CourseCategoryID = @CourseCategoryID )
		SELECT @CourseCategoryID = ParentCategoryID FROM CourseCategory WHERE CourseCategoryID = @CourseCategoryID
	ELSE 
		SELECT @CourseCategoryID = 0
END

GO