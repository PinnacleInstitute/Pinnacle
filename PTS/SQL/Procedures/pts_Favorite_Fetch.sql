EXEC [dbo].pts_CheckProc 'pts_Favorite_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Favorite_Fetch ( 
   @FavoriteID int,
   @MemberID int OUTPUT,
   @RefType int OUTPUT,
   @RefID int OUTPUT,
   @FavoriteDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = fav.MemberID ,
   @RefType = fav.RefType ,
   @RefID = fav.RefID ,
   @FavoriteDate = fav.FavoriteDate
FROM Favorite AS fav (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (fav.MemberID = me.MemberID)
WHERE fav.FavoriteID = @FavoriteID

GO