EXEC [dbo].pts_CheckProc 'pts_Payout_FindDateOwnerShowPayDate'
 GO

CREATE PROCEDURE [dbo].pts_Payout_FindDateOwnerShowPayDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @FromDate datetime,
   @ToDate datetime,
   @Show int,
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
            ISNULL(CONVERT(nvarchar(10), po.PayDate, 112), '') + dbo.wtfn_FormatNumber(po.PayoutID, 10) 'BookMark' ,
            po.PayoutID 'PayoutID' ,
            po.CompanyID 'CompanyID' ,
            po.OwnerType 'OwnerType' ,
            po.OwnerID 'OwnerID' ,
            po.PayDate 'PayDate' ,
            po.PaidDate 'PaidDate' ,
            po.Amount 'Amount' ,
            po.Status 'Status' ,
            po.Notes 'Notes' ,
            po.PayType 'PayType' ,
            po.Reference 'Reference' ,
            po.Show 'Show'
FROM Payout AS po (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), po.PayDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), po.PayDate, 112), '') + dbo.wtfn_FormatNumber(po.PayoutID, 10) <= @BookMark
AND         (po.OwnerType = @OwnerType)
AND         (po.OwnerID = @OwnerID)
AND         (po.PayDate >= @FromDate)
AND         (po.PayDate <= @ToDate)
AND         (po.Show <= @Show)
ORDER BY 'Bookmark' DESC

GO