EXEC [dbo].pts_CheckProc 'pts_Note_Count'
 GO

CREATE PROCEDURE [dbo].pts_Note_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Note AS nt (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO