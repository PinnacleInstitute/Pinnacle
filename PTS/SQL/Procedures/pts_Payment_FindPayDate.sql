EXEC [dbo].pts_CheckProc 'pts_Payment_FindPayDate'
 GO

CREATE PROCEDURE [dbo].pts_Payment_FindPayDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
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
            ISNULL(CONVERT(nvarchar(10), pa.PayDate, 112), '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), pa.PayDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pa.PayDate, 112), '') + dbo.wtfn_FormatNumber(pa.PaymentID, 10) <= @BookMark
AND         (pa.CompanyID = @CompanyID)
ORDER BY 'Bookmark' DESC

GO