EXEC [dbo].pts_CheckProc 'pts_Ad_Count'
 GO

CREATE PROCEDURE [dbo].pts_Ad_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Ad AS adv (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO