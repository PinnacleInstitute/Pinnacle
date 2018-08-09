EXEC [dbo].pts_CheckProc 'pts_Session_Count'
 GO

CREATE PROCEDURE [dbo].pts_Session_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Session AS se (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO