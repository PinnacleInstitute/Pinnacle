EXEC [dbo].pts_CheckProc 'pts_Course_Count'
 GO

CREATE PROCEDURE [dbo].pts_Course_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Course AS cs (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO