EXEC [dbo].pts_CheckProc 'pts_Page_EnumPageList'
GO

CREATE PROCEDURE [dbo].pts_Page_EnumPageList
   @CompanyID int ,
   @MemberID int ,
   @GroupID1 int ,
   @GroupID2 int ,
   @GroupID3 int ,
   @PageType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pg.PageID AS 'ID', 
         CASE WHEN pg.Category!='' THEN pg.Category + ': ' ELSE '' END + pg.PageName AS 'Name'
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

ORDER BY   pg.Category , pg.PageName

GO