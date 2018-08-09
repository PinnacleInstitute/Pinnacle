EXEC [dbo].pts_CheckProc 'pts_Lead_Count'
 GO

CREATE PROCEDURE [dbo].pts_Lead_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Lead AS ld (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO