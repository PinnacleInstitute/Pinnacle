EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Delete'
 GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Delete ( 
   @CourseCategoryID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cc
FROM CourseCategory AS cc
WHERE cc.CourseCategoryID = @CourseCategoryID

GO