EXEC [dbo].pts_CheckProc 'pts_Payment_Count'
 GO

CREATE PROCEDURE [dbo].pts_Payment_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Payment AS pa (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO