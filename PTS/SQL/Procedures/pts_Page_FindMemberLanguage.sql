EXEC [dbo].pts_CheckProc 'pts_Page_FindMemberLanguage'
 GO

CREATE PROCEDURE [dbo].pts_Page_FindMemberLanguage ( 
   @SearchText varchar (6),
   @Bookmark varchar (16),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @PageType int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pg.Language, '') + dbo.wtfn_FormatNumber(pg.PageID, 10) 'BookMark' ,
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
WHERE ISNULL(pg.Language, '') LIKE @SearchText + '%'
AND ISNULL(pg.Language, '') + dbo.wtfn_FormatNumber(pg.PageID, 10) >= @BookMark
AND         (pg.MemberID = @MemberID)
AND         (pg.PageType = @PageType)
ORDER BY 'Bookmark'

GO