EXEC [dbo].pts_CheckProc 'pts_Message_Count'
 GO

CREATE PROCEDURE [dbo].pts_Message_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Message AS mbm (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO