EXEC [dbo].pts_CheckProc 'pts_BarterAd_FindBarterAdID'
 GO

CREATE PROCEDURE [dbo].pts_BarterAd_FindBarterAdID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @ConsumerID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), bad.BarterAdID), '') + dbo.wtfn_FormatNumber(bad.BarterAdID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), bad.BarterAdID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bad.BarterAdID), '') + dbo.wtfn_FormatNumber(bad.BarterAdID, 10) >= @BookMark
AND         (bad.ConsumerID = @ConsumerID)
ORDER BY 'Bookmark'

GO