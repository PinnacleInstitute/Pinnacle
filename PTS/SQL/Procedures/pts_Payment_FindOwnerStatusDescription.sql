EXEC [dbo].pts_CheckProc 'pts_Payment_FindOwnerStatusDescription'
 GO

CREATE PROCEDURE [dbo].pts_Payment_FindOwnerStatusDescription ( 
   @SearchText varchar (200),
   @Bookmark varchar (210),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pa.Description, '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) 'BookMark' ,
            pa.PaymentID 'PaymentID' ,
            pa.CompanyID 'CompanyID' ,
            pa.OwnerType 'OwnerType' ,
            pa.OwnerID 'OwnerID' ,
            pa.BillingID 'BillingID' ,
            pa.ProductID 'ProductID' ,
            pa.PaidID 'PaidID' ,
            pa.PayDate 'PayDate' ,
            pa.PaidDate 'PaidDate' ,
            pa.PayType 'PayType' ,
            pa.Amount 'Amount' ,
            pa.Total 'Total' ,
            pa.Credit 'Credit' ,
            pa.Retail 'Retail' ,
            pa.Commission 'Commission' ,
            pa.Description 'Description' ,
            pa.Purpose 'Purpose' ,
            pa.Status 'Status' ,
            pa.Reference 'Reference' ,
            pa.Notes 'Notes' ,
            pa.CommStatus 'CommStatus' ,
            pa.CommDate 'CommDate' ,
            pa.TokenType 'TokenType' ,
            pa.TokenOwner 'TokenOwner' ,
            pa.Token 'Token'
FROM Payment AS pa (NOLOCK)
WHERE ISNULL(pa.Description, '') LIKE '%' + @SearchText + '%'
AND ISNULL(pa.Description, '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) >= @BookMark
AND         (pa.OwnerType = @OwnerType)
AND         (pa.OwnerID = @OwnerID)
AND         (pa.Status = @Status)
ORDER BY 'Bookmark'

GO