EXEC [dbo].pts_CheckProc 'pts_Page_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_Page_ListCompany
   @CompanyID int ,
   @PageType int
AS

SET NOCOUNT ON

SELECT      pg.PageID, 
         pg.PageName, 
         pg.Category, 
         pg.Status, 
         pg.Language
FROM Page AS pg (NOLOCK)
WHERE (pg.CompanyID = @CompanyID)
 AND (pg.PageType = @PageType)

ORDER BY   pg.PageName

GO