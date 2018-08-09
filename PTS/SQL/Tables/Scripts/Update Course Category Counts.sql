-- ********************************************************************************************************
-- Assign CourseCategory Titles based on QV
-- ********************************************************************************************************
DECLARE @CourseCategoryID int
UPDATE CourseCategory SET CourseCount = 0 

DECLARE CourseCategory_Cursor CURSOR LOCAL STATIC FOR 
SELECT CourseCategoryID FROM CourseCategory AS cc
WHERE 0 = (SELECT COUNT(*) FROM CourseCategory WHERE ParentCategoryID = cc.CourseCategoryID )

OPEN CourseCategory_Cursor
FETCH NEXT FROM CourseCategory_Cursor INTO @CourseCategoryID

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_CourseCategory_Update_Counters @CourseCategoryID
	FETCH NEXT FROM CourseCategory_Cursor INTO @CourseCategoryID
END
CLOSE CourseCategory_Cursor
DEALLOCATE CourseCategory_Cursor


-- select * from coursecategory



