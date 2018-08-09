EXEC [dbo].pts_CheckProc 'pts_Party_Count'
 GO

CREATE PROCEDURE [dbo].pts_Party_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Party AS py (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO