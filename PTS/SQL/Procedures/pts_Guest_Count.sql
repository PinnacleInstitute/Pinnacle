EXEC [dbo].pts_CheckProc 'pts_Guest_Count'
 GO

CREATE PROCEDURE [dbo].pts_Guest_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Guest AS gu (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO