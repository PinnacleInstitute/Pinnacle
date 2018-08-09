EXEC [dbo].pts_CheckProc 'pts_Favorite_CheckFavorite'
GO

CREATE PROCEDURE [dbo].pts_Favorite_CheckFavorite
   @MemberID int ,
   @RefType int ,
   @RefID int ,
   @UserID int ,
   @FavoriteID int OUTPUT
AS

DECLARE @mFavoriteID int

SET NOCOUNT ON

SELECT      @mFavoriteID = fav.FavoriteID
FROM Favorite AS fav (NOLOCK)
WHERE (fav.MemberID = @MemberID)
 AND (fav.RefType = @RefType)
 AND (fav.RefID = @RefID)


SET @FavoriteID = ISNULL(@mFavoriteID, 0)
GO