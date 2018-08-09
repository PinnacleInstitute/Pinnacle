EXEC [dbo].pts_CheckProc 'pts_Payment_FindMemberReference'
 GO

CREATE PROCEDURE [dbo].pts_Payment_FindMemberReference ( 
   @SearchText varchar (40),
   @Bookmark varchar (50),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FromDate datetime,
   @ToDate datetime,
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
LEFT OUTER JOIN SalesOrder AS so (NOLOCK) ON (pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID)
WHERE ISNULL(pa.Reference, '') LIKE @SearchText + '%'
AND ISNULL(pa.Reference, '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) >= @BookMark
AND         (so.MemberID = @MemberID)
AND         (pa.PayDate >= @FromDate)
AND         (pa.PayDate <= @ToDate)
ORDER BY 'Bookmark'

GO