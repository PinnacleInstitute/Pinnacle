EXEC [dbo].pts_CheckProc 'pts_BarterAd_FindTitle'
 GO

CREATE PROCEDURE [dbo].pts_BarterAd_FindTitle ( 
   @SearchText nvarchar (100),
   @Bookmark nvarchar (110),
   @MaxRows tinyint OUTPUT,
   @ConsumerID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(bad.Title, '') + dbo.wtfn_FormatNumber(bad.BarterAdID, 10) 'BookMark' ,
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
WHERE ISNULL(bad.Title, '') LIKE '%' + @SearchText + '%'
AND ISNULL(bad.Title, '') + dbo.wtfn_FormatNumber(bad.BarterAdID, 10) >= @BookMark
AND         (bad.ConsumerID = @ConsumerID)
ORDER BY 'Bookmark'

GO