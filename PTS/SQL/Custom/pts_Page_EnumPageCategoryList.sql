EXEC [dbo].pts_CheckProc 'pts_Page_EnumPageCategoryList'
GO

--EXEC pts_Page_EnumPageCategoryList 7, 6528, 7667, 0, 0, 7, 1
--EXEC pts_Page_EnumPageCategoryList 13, 6528, 7667, 0, 0, 7, 1
--select * from Page

CREATE PROCEDURE [dbo].pts_Page_EnumPageCategoryList
   @CompanyID int ,
   @MemberID int ,
   @GroupID1 int ,
   @GroupID2 int ,
   @GroupID3 int ,
   @PageType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT  
	MIN(pg.PageID) AS 'ID', 
    pg.Category AS 'Name'
FROM Page AS pg (NOLOCK)
WHERE (pg.CompanyID = @CompanyID)
 AND (pg.Status = 1)
 AND (pg.PageType = @PageType)
 AND ((pg.MemberID = 0)
 OR (pg.MemberID = @MemberID)
 OR ((pg.MemberID = @GroupID1)
 AND (pg.IsShare <> 0))
 OR ((pg.MemberID = @GroupID2)
 AND (pg.IsShare <> 0))
 OR ((pg.MemberID = @GroupID3)
 AND (pg.IsShare <> 0)))

GROUP BY pg.Category
ORDER BY pg.Category

GO