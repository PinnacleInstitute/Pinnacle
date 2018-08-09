EXEC [dbo].pts_CheckProc 'pts_Assessment_Count'
 GO

CREATE PROCEDURE [dbo].pts_Assessment_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Assessment AS asm (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO