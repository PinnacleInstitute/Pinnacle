EXEC [dbo].pts_CheckProc 'pts_Event_Count'
 GO

CREATE PROCEDURE [dbo].pts_Event_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Event AS ev (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO