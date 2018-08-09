EXEC [dbo].pts_CheckProc 'pts_Calendar_Count'
 GO

CREATE PROCEDURE [dbo].pts_Calendar_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Calendar AS cal (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO