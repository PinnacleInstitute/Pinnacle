EXEC [dbo].pts_CheckProc 'pts_Page_Count'
 GO

CREATE PROCEDURE [dbo].pts_Page_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Page AS pg (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO