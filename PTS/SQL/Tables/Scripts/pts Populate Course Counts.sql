
DECLARE @CourseCount int, @MemberCount int, @Hierarchy varchar(100), @ID int, @NewCourseCount int, @NewMemberCount int

UPDATE Org SET CourseCount = 0, MemberCount = 0

DECLARE Org_cursor CURSOR DYNAMIC FOR 
SELECT  OrgID, Hierarchy, MemberCount, CourseCount FROM Org
ORDER BY [Level] DESC

OPEN Org_cursor
FETCH NEXT FROM Org_cursor INTO @ID, @Hierarchy, @CourseCount, @MemberCount

WHILE @@FETCH_STATUS = 0
BEGIN
 
Set @NewCourseCount = (SELECT COUNT(*) FROM OrgCourse WHERE OrgID = @ID) + ISNULL((SELECT SUM(CourseCount) FROM Org WHERE ParentID = @ID), 0)
Set @NewMemberCount = (SELECT COUNT(*) FROM OrgMember WHERE OrgID = @ID) + ISNULL((SELECT SUM(MemberCount) FROM Org WHERE ParentID = @ID), 0)

UPDATE Org
SET    CourseCount = @NewCourseCount,
       MemberCount = @NewMemberCount
WHERE  OrgID = @ID

FETCH NEXT FROM Org_cursor INTO @ID, @Hierarchy, @CourseCount, @MemberCount
END

CLOSE Org_cursor
DEALLOCATE Org_cursor

---update course category course counts
---use coursecount first to calculate level, then calculate courses

UPDATE CourseCategory  
SET CourseCount = -1

DECLARE @cnt int, @childcnt int

DECLARE Category_cursor CURSOR DYNAMIC FOR 
SELECT  CourseCategoryID FROM CourseCategory
WHERE CourseCount = -1
ORDER BY CourseCategoryID DESC

OPEN Category_cursor
FETCH NEXT FROM Category_cursor INTO @ID

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @cnt = COUNT(*) FROM Course WHERE CourseCategoryID = @ID AND Status = 3
	SELECT @childcnt = Sum(CourseCount) FROM CourseCategory WHERE ParentCategoryID = @ID
	
	UPDATE CourseCategory  
	SET CourseCount = ISNULL(@cnt,0) + ISNULL(@childcnt,0)
	WHERE CourseCategoryID = @ID
	
	FETCH NEXT FROM Category_cursor INTO @ID
END
	
CLOSE Category_cursor
DEALLOCATE Category_cursor