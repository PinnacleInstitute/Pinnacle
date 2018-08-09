EXEC [dbo].pts_CheckProc 'pts_PageSection_Count'
 GO

CREATE PROCEDURE [dbo].pts_PageSection_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM PageSection AS ps (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO