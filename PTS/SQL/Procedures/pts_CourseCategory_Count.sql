EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Count'
 GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM CourseCategory AS cc (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO