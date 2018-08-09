EXEC [dbo].pts_CheckProc 'pts_BonusItem_Count'
 GO

CREATE PROCEDURE [dbo].pts_BonusItem_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM BonusItem AS bi (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO