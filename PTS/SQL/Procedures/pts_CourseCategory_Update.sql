EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Update'
 GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Update ( 
   @CourseCategoryID int,
   @ParentCategoryID int,
   @ForumID int,
   @CourseCategoryName nvarchar (60),
   @Seq int,
   @CourseCount int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cc
SET cc.ParentCategoryID = @ParentCategoryID ,
   cc.ForumID = @ForumID ,
   cc.CourseCategoryName = @CourseCategoryName ,
   cc.Seq = @Seq ,
   cc.CourseCount = @CourseCount
FROM CourseCategory AS cc
WHERE cc.CourseCategoryID = @CourseCategoryID

GO