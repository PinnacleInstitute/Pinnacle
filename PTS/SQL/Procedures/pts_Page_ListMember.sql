EXEC [dbo].pts_CheckProc 'pts_Page_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Page_ListMember
   @MemberID int ,
   @PageType int
AS

SET NOCOUNT ON

SELECT      pg.PageID, 
         pg.PageName, 
         pg.Category, 
         pg.Status, 
         pg.Language
FROM Page AS pg (NOLOCK)
WHERE (pg.MemberID = @MemberID)
 AND (pg.PageType = @PageType)

ORDER BY   pg.PageName

GO