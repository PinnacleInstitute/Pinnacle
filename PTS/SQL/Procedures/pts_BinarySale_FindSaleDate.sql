EXEC [dbo].pts_CheckProc 'pts_BinarySale_FindSaleDate'
 GO

CREATE PROCEDURE [dbo].pts_BinarySale_FindSaleDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
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
            ISNULL(CONVERT(nvarchar(10), bs.SaleDate, 112), '') + dbo.wtfn_FormatNumber(bs.BinarySaleID, 10) 'BookMark' ,
            bs.BinarySaleID 'BinarySaleID' ,
            bs.MemberID 'MemberID' ,
            bs.RefID 'RefID' ,
            bs.SaleDate 'SaleDate' ,
            bs.SaleType 'SaleType' ,
            bs.Amount 'Amount'
FROM BinarySale AS bs (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), bs.SaleDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bs.SaleDate, 112), '') + dbo.wtfn_FormatNumber(bs.BinarySaleID, 10) <= @BookMark
AND         (bs.MemberID = @MemberID)
ORDER BY 'Bookmark' DESC

GO