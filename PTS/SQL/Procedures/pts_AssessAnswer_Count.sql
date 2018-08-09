EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_Count'
 GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM AssessAnswer AS asa (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO