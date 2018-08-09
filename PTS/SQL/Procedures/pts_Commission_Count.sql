EXEC [dbo].pts_CheckProc 'pts_Commission_Count'
 GO

CREATE PROCEDURE [dbo].pts_Commission_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Commission AS co (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO