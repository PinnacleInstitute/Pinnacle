EXEC [dbo].pts_CheckProc 'pts_Member_Count'
 GO

CREATE PROCEDURE [dbo].pts_Member_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Member AS me (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO