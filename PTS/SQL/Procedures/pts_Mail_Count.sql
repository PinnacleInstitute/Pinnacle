EXEC [dbo].pts_CheckProc 'pts_Mail_Count'
 GO

CREATE PROCEDURE [dbo].pts_Mail_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Mail AS ml (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO