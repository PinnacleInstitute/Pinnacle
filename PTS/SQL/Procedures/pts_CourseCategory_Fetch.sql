EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Fetch ( 
   @CourseCategoryID int,
   @ParentCategoryID int OUTPUT,
   @ForumID int OUTPUT,
   @ParentCategoryName nvarchar (60) OUTPUT,
   @CourseCategoryName nvarchar (60) OUTPUT,
   @Seq int OUTPUT,
   @CourseCount int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ParentCategoryID = cc.ParentCategoryID ,
   @ForumID = cc.ForumID ,
   @ParentCategoryName = ccp.CourseCategoryName ,
   @CourseCategoryName = cc.CourseCategoryName ,
   @Seq = cc.Seq ,
   @CourseCount = cc.CourseCount
FROM CourseCategory AS cc (NOLOCK)
LEFT OUTER JOIN CourseCategory AS ccp (NOLOCK) ON (cc.ParentCategoryID = ccp.CourseCategoryID)
WHERE cc.CourseCategoryID = @CourseCategoryID

GO