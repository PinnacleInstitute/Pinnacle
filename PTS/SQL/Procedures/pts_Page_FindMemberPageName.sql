EXEC [dbo].pts_CheckProc 'pts_Page_FindMemberPageName'
 GO

CREATE PROCEDURE [dbo].pts_Page_FindMemberPageName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @PageType int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pg.PageName, '') + dbo.wtfn_FormatNumber(pg.PageID, 10) 'BookMark' ,
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
WHERE ISNULL(pg.PageName, '') LIKE @SearchText + '%'
AND ISNULL(pg.PageName, '') + dbo.wtfn_FormatNumber(pg.PageID, 10) >= @BookMark
AND         (pg.MemberID = @MemberID)
AND         (pg.PageType = @PageType)
ORDER BY 'Bookmark'

GO