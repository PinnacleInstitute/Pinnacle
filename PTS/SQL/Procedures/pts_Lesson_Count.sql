EXEC [dbo].pts_CheckProc 'pts_Lesson_Count'
 GO

CREATE PROCEDURE [dbo].pts_Lesson_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Lesson AS le (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO