EXEC [dbo].pts_CheckProc 'pts_Page_FindCompanyPageID'
 GO

CREATE PROCEDURE [dbo].pts_Page_FindCompanyPageID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @PageType int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), pg.PageID), '') + dbo.wtfn_FormatNumber(pg.PageID, 10) 'BookMark' ,
            pg.PageID 'PageID' ,
            pg.CompanyID 'CompanyID' ,
            pg.MemberID 'MemberID' ,
            pg.PageName 'PageName' ,
            pg.Category 'Category' ,
            pg.PageType 'PageType' ,
            pg.Status 'Status' ,
            pg.Language 'Language' ,
            pg.IsPrivate 'IsPrivate' ,
            pg.Form 'Form' ,
            pg.Fields 'Fields' ,
            pg.IsShare 'IsShare' ,
            pg.Subject 'Subject'
FROM Page AS pg (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), pg.PageID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pg.PageID), '') + dbo.wtfn_FormatNumber(pg.PageID, 10) >= @BookMark
AND         (pg.CompanyID = @CompanyID)
AND         (pg.PageType = @PageType)
ORDER BY 'Bookmark'

GO