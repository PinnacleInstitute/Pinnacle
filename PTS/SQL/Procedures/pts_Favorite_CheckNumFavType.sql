EXEC [dbo].pts_CheckProc 'pts_Favorite_CheckNumFavType'
GO

CREATE PROCEDURE [dbo].pts_Favorite_CheckNumFavType
   @MemberID int ,
   @RefType int ,
   @UserID int ,
   @Count int OUTPUT
AS

DECLARE @mCount int

SET NOCOUNT ON

SELECT      @mCount = COUNT(*)
FROM Favorite AS fav (NOLOCK)
WHERE (fav.MemberID = @MemberID)
 AND (fav.RefType = @RefType)


SET @Count = ISNULL(@mCount, 0)
GO