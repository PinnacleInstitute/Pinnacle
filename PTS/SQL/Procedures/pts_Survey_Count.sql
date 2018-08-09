EXEC [dbo].pts_CheckProc 'pts_Survey_Count'
 GO

CREATE PROCEDURE [dbo].pts_Survey_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Survey AS su (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO