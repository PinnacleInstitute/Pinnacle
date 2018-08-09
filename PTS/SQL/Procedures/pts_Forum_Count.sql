EXEC [dbo].pts_CheckProc 'pts_Forum_Count'
 GO

CREATE PROCEDURE [dbo].pts_Forum_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Forum AS mbf (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO