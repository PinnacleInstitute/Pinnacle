EXEC [dbo].pts_CheckProc 'pts_Page_ListForm'
GO

CREATE PROCEDURE [dbo].pts_Page_ListForm
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
 AND (pg.Status = 1)

ORDER BY   pg.Category , pg.PageName

GO