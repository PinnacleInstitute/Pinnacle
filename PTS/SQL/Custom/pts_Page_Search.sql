EXEC [dbo].pts_CheckProc 'pts_Page_Search'
 GO

CREATE PROCEDURE [dbo].pts_Page_Search ( 
      @SearchText nvarchar (200),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT,
      @CompanyID int,
      @MemberID int,
      @GroupID1 int,
      @GroupID2 int,
      @GroupID3 int,
      @PageType int,
      @Secure int
      )
AS

SET NOCOUNT ON

SET @MaxRows = 20

IF @Bookmark = '' 
	SET @Bookmark = '9999'

SELECT TOP 21
	dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(pg.PageID, 10) 'BookMark' ,
	pg.PageID,
	pg.PageName,
	pg.Category,
	pg.Subject,
	pg.Fields
FROM Page AS pg
INNER JOIN CONTAINSTABLE(PageFT,*, @SearchText, 1000 ) AS K ON pg.PageID = K.[KEY]
WHERE dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(pg.PageID, 10) <= @Bookmark
AND pg.CompanyID = @CompanyID
AND pg.Status = 1
AND (pg.PageType = @PageType)
AND ((pg.MemberID = 0) 
OR  (pg.MemberID = @MemberID)
OR  ((pg.MemberID = @GroupID1)
AND (pg.IsShare <> 0))
OR  ((pg.MemberID = @GroupID2)
AND (pg.IsShare <> 0))
OR  ((pg.MemberID = @GroupID3)
AND (pg.IsShare <> 0)))

ORDER BY 'Bookmark' desc 

GO