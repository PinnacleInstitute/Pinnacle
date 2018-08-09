EXEC [dbo].pts_CheckProc 'pts_Page_ListFormPublic'
GO

CREATE PROCEDURE [dbo].pts_Page_ListFormPublic
   @CompanyID int ,
   @Form int
AS

SET NOCOUNT ON

SELECT      pg.PageID, 
         pg.PageName, 
         pg.Category
FROM Page AS pg (NOLOCK)
WHERE (pg.CompanyID = @CompanyID)
 AND (pg.Form = @Form)
 AND (pg.IsPrivate = 0)
 AND (pg.Status = 1)

ORDER BY   pg.Category , pg.PageName

GO