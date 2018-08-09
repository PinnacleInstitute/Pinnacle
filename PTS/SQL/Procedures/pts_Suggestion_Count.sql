EXEC [dbo].pts_CheckProc 'pts_Suggestion_Count'
 GO

CREATE PROCEDURE [dbo].pts_Suggestion_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Suggestion AS sg (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO