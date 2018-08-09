EXEC [dbo].pts_CheckProc 'pts_BarterAd_FindUpdateDate'
 GO

CREATE PROCEDURE [dbo].pts_BarterAd_FindUpdateDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @ConsumerID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), bad.UpdateDate, 112), '') + dbo.wtfn_FormatNumber(bad.BarterAdID, 10) 'BookMark' ,
            bad.BarterAdID 'BarterAdID' ,
            bad.Title 'Title' ,
            bad.Status 'Status' ,
            bad.Price 'Price' ,
            bad.Condition 'Condition' ,
            bad.PostDate 'PostDate' ,
            bad.UpdateDate 'UpdateDate' ,
            bad.Images 'Images' ,
            bad.Options 'Options'
FROM BarterAd AS bad (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), bad.UpdateDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bad.UpdateDate, 112), '') + dbo.wtfn_FormatNumber(bad.BarterAdID, 10) <= @BookMark
AND         (bad.ConsumerID = @ConsumerID)
ORDER BY 'Bookmark' DESC

GO