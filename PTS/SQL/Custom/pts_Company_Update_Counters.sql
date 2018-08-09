EXEC [dbo].pts_CheckProc 'pts_Company_Update_Counters'
GO

CREATE PROCEDURE [dbo].pts_Company_Update_Counters
   @CompanyID int
AS

SET NOCOUNT ON

DECLARE @ID int, @NewCourseCount int, @NewMemberCount int

UPDATE Org SET CourseCount = 0, MemberCount = 0 WHERE CompanyID = @CompanyID

DECLARE Org_cursor CURSOR DYNAMIC FOR 
SELECT  OrgID FROM Org WHERE CompanyID = @CompanyID ORDER BY [Level] DESC

OPEN Org_cursor
FETCH NEXT FROM Org_cursor INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN
	Set @NewCourseCount = (SELECT COUNT(*) FROM OrgCourse WHERE OrgID = @ID) +
		ISNULL((SELECT SUM(CourseCount) FROM Org WHERE ParentID = @ID), 0)
	Set @NewMemberCount = (SELECT COUNT(*) FROM OrgMember WHERE OrgID = @ID) + 
		ISNULL((SELECT SUM(MemberCount) FROM Org WHERE ParentID = @ID), 0)
	
	UPDATE Org
	SET    CourseCount = @NewCourseCount,
	       MemberCount = @NewMemberCount
	WHERE  OrgID = @ID
	
	FETCH NEXT FROM Org_cursor INTO @ID
END

CLOSE Org_cursor
DEALLOCATE Org_cursor

GO