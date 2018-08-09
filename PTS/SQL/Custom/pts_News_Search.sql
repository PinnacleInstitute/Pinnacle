EXEC [dbo].pts_CheckProc 'pts_News_Search'
 GO

--DECLARE @MaxRows tinyint EXEC pts_News_Search 'fraud', '', @MaxRows, 12

CREATE PROCEDURE [dbo].pts_News_Search ( 
      @SearchText nvarchar (200),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT,
      @CompanyID int,
      @FromDate datetime,
      @ToDate datetime
      )
AS

SET NOCOUNT ON

SET @MaxRows = 20

IF @Bookmark = '' 
	SET @Bookmark = '9999'

SELECT TOP 21
	dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(ne.NewsID, 10) 'BookMark' ,
	ne.NewsID,
	ne.Title,
	ne.Description,
	ne.Tags,
	ne.ActiveDate,
	ne.Image,
	ne.LeadMain,
	ne.LeadTopic,
	ne.IsBreaking,
	ne.IsBreaking2,
	ne.IsStrategic
FROM News AS ne
INNER JOIN CONTAINSTABLE(News,*, @SearchText, 1000 ) AS K ON ne.NewsID = K.[KEY]
WHERE dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(ne.NewsID, 10) <= @Bookmark
AND ne.CompanyID = @CompanyID
AND ne.Status = 4
AND ne.ActiveDate >= @FromDate
AND ne.ActiveDate <= @ToDate
ORDER BY 'Bookmark' desc 

GO