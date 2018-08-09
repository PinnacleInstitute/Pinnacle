EXEC [dbo].pts_CheckProc 'pts_News_Count'
 GO

CREATE PROCEDURE [dbo].pts_News_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM News AS nw (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO