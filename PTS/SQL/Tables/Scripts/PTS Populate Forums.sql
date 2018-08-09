
DECLARE @ForumID int, @ID int, @Name nvarchar(60)

--Update the Org

DECLARE Org_cursor CURSOR FOR 
SELECT OrgID, OrgName
FROM Org
WHERE ForumID = 0

OPEN Org_cursor
FETCH NEXT FROM Org_cursor INTO @ID, @Name

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Forum_Add @ForumID OUTPUT, 0, @Name, 0, '', 1 

	UPDATE Org
	SET ForumID = @ForumID
	WHERE OrgID = @ID

	FETCH NEXT FROM Org_cursor INTO @ID, @Name
END

CLOSE Org_cursor
DEALLOCATE Org_cursor

--Update the CourseCategory

DECLARE CourseCategory_cursor CURSOR FOR 
SELECT CourseCategoryID, CourseCategoryName
FROM CourseCategory
WHERE ForumID = 0

OPEN CourseCategory_cursor
FETCH NEXT FROM CourseCategory_cursor INTO @ID, @Name

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Forum_Add @ForumID OUTPUT, 0, @Name, 0, '', 1 

	UPDATE CourseCategory
	SET ForumID = @ForumID
	WHERE CourseCategoryID = @ID

	FETCH NEXT FROM CourseCategory_cursor INTO @ID, @Name
END

CLOSE CourseCategory_cursor
DEALLOCATE CourseCategory_cursor