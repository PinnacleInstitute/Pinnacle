EXEC [dbo].pts_CheckProc 'pts_Goal_Count'
 GO

CREATE PROCEDURE [dbo].pts_Goal_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Goal AS go (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO