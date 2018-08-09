EXEC [dbo].pts_CheckProc 'pts_Favorite_Count'
 GO

CREATE PROCEDURE [dbo].pts_Favorite_Count ( 
   @UserID int
      )
AS

DECLARE @mCount int

SET NOCOUNT ON


SELECT   @mCount = COUNT(*)
FROM Favorite AS fav (NOLOCK)

RETURN ISNULL(@mCount, 0)

GO