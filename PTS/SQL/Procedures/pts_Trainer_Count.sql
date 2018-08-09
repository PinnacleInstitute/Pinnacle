EXEC [dbo].pts_CheckProc 'pts_Trainer_Count'
 GO

CREATE PROCEDURE [dbo].pts_Trainer_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Trainer AS tr (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO