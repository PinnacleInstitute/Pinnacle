EXEC [dbo].pts_CheckProc 'pts_Friend_Count'
 GO

CREATE PROCEDURE [dbo].pts_Friend_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Friend AS fr (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO