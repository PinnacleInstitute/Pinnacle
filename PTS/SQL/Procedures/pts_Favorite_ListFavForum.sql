EXEC [dbo].pts_CheckProc 'pts_Favorite_ListFavForum'
GO

CREATE PROCEDURE [dbo].pts_Favorite_ListFavForum
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      fav.FavoriteID, 
         fav.MemberID, 
         fav.RefType, 
         fav.RefID, 
         fav.FavoriteDate, 
         mbf.ForumName
FROM Favorite AS fav (NOLOCK)
LEFT OUTER JOIN Forum AS mbf (NOLOCK) ON (fav.RefID = mbf.ForumID)
WHERE (fav.RefType = 4)
 AND (fav.MemberID = @MemberID)


GO