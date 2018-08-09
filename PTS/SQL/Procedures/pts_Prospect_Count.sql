EXEC [dbo].pts_CheckProc 'pts_Prospect_Count'
 GO

CREATE PROCEDURE [dbo].pts_Prospect_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Prospect AS pr (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO