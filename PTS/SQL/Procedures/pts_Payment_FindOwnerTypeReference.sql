EXEC [dbo].pts_CheckProc 'pts_Payment_FindOwnerTypeReference'
 GO

CREATE PROCEDURE [dbo].pts_Payment_FindOwnerTypeReference ( 
   @SearchText varchar (40),
   @Bookmark varchar (50),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @PayType int,
   @Token int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pa.Reference, '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) 'BookMark' ,
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
WHERE ISNULL(pa.Reference, '') LIKE @SearchText + '%'
AND ISNULL(pa.Reference, '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) >= @BookMark
AND         (pa.OwnerType = @OwnerType)
AND         (pa.OwnerID = @OwnerID)
AND         (pa.PayType >= @PayType)
AND         (pa.PayType <= @Token)
ORDER BY 'Bookmark'

GO