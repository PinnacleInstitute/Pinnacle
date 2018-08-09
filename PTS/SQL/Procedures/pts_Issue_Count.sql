EXEC [dbo].pts_CheckProc 'pts_Issue_Count'
 GO

CREATE PROCEDURE [dbo].pts_Issue_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Issue AS zis (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO