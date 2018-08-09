EXEC [dbo].pts_CheckProc 'pts_Favorite_ListFavCourseCategory'
GO

CREATE PROCEDURE [dbo].pts_Favorite_ListFavCourseCategory
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      fav.FavoriteID, 
         fav.MemberID, 
         fav.RefType, 
         fav.RefID, 
         fav.FavoriteDate, 
         cc.CourseCategoryName
FROM Favorite AS fav (NOLOCK)
LEFT OUTER JOIN CourseCategory AS cc (NOLOCK) ON (fav.RefID = cc.CourseCategoryID)
WHERE (fav.RefType = 1)
 AND (fav.MemberID = @MemberID)


GO