EXEC [dbo].pts_CheckProc 'pts_BinarySale_FindSaleType'
 GO

CREATE PROCEDURE [dbo].pts_BinarySale_FindSaleType ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), bs.SaleType), '') + dbo.wtfn_FormatNumber(bs.BinarySaleID, 10) 'BookMark' ,
            bs.BinarySaleID 'BinarySaleID' ,
            bs.MemberID 'MemberID' ,
            bs.RefID 'RefID' ,
            bs.SaleDate 'SaleDate' ,
            bs.SaleType 'SaleType' ,
            bs.Amount 'Amount'
FROM BinarySale AS bs (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), bs.SaleType), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bs.SaleType), '') + dbo.wtfn_FormatNumber(bs.BinarySaleID, 10) >= @BookMark
AND         (bs.MemberID = @MemberID)
ORDER BY 'Bookmark'

GO