EXEC [dbo].pts_CheckProc 'pts_Bonus_Count'
 GO

CREATE PROCEDURE [dbo].pts_Bonus_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Bonus AS bo (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO