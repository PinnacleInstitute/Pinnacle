EXEC [dbo].pts_CheckProc 'pts_Favorite_ListFavOrg'
GO

CREATE PROCEDURE [dbo].pts_Favorite_ListFavOrg
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      fav.FavoriteID, 
         fav.MemberID, 
         fav.RefType, 
         fav.RefID, 
         fav.FavoriteDate, 
         org.OrgName
FROM Favorite AS fav (NOLOCK)
LEFT OUTER JOIN Org AS org (NOLOCK) ON (fav.RefID = org.OrgID)
WHERE (fav.RefType = 2)
 AND (fav.MemberID = @MemberID)


GO