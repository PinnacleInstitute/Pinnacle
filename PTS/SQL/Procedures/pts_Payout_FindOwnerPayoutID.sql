EXEC [dbo].pts_CheckProc 'pts_Payout_FindOwnerPayoutID'
 GO

CREATE PROCEDURE [dbo].pts_Payout_FindOwnerPayoutID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), po.PayoutID), '') + dbo.wtfn_FormatNumber(po.PayoutID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), po.PayoutID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), po.PayoutID), '') + dbo.wtfn_FormatNumber(po.PayoutID, 10) >= @BookMark
AND         (po.OwnerType = @OwnerType)
AND         (po.OwnerID = @OwnerID)
ORDER BY 'Bookmark'

GO