EXEC [dbo].pts_CheckProc 'pts_Favorite_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Favorite_Delete ( 
   @FavoriteID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE fav
FROM Favorite AS fav
WHERE fav.FavoriteID = @FavoriteID

GO