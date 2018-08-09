EXEC [dbo].pts_CheckProc 'pts_Page_FindCompanyCategoryCategory'
 GO

CREATE PROCEDURE [dbo].pts_Page_FindCompanyCategoryCategory ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (30),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @PageType int,
   @Category nvarchar (20),
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pg.Category, '') + dbo.wtfn_FormatNumber(pg.PageID, 10) 'BookMark' ,
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
WHERE ISNULL(pg.Category, '') LIKE @SearchText + '%'
AND ISNULL(pg.Category, '') + dbo.wtfn_FormatNumber(pg.PageID, 10) >= @BookMark
AND         (pg.CompanyID = @CompanyID)
AND         (pg.PageType = @PageType)
AND         (pg.Category = @Category)
ORDER BY 'Bookmark'

GO