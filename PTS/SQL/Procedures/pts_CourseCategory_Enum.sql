EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Enum'
 GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         cc.CourseCategoryID 'ID' ,
            cc.CourseCategoryName 'Name'
FROM CourseCategory AS cc (NOLOCK)
ORDER BY cc.Seq

GO