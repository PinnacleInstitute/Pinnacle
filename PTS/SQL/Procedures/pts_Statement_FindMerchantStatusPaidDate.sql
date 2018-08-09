EXEC [dbo].pts_CheckProc 'pts_Statement_FindMerchantStatusPaidDate'
 GO

CREATE PROCEDURE [dbo].pts_Statement_FindMerchantStatusPaidDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MerchantID int,
   @Status int,
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
            ISNULL(CONVERT(nvarchar(10), stm.PaidDate, 112), '') + dbo.wtfn_FormatNumber(stm.StatementID, 10) 'BookMark' ,
            stm.StatementID 'StatementID' ,
            stm.CompanyID 'CompanyID' ,
            stm.MerchantID 'MerchantID' ,
            mer.MerchantName 'MerchantName' ,
            stm.StatementDate 'StatementDate' ,
            stm.PaidDate 'PaidDate' ,
            stm.Amount 'Amount' ,
            stm.Status 'Status' ,
            stm.PayType 'PayType' ,
            stm.Reference 'Reference' ,
            stm.Notes 'Notes'
FROM Statement AS stm (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (stm.MerchantID = mer.MerchantID)
WHERE ISNULL(CONVERT(nvarchar(10), stm.PaidDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), stm.PaidDate, 112), '') + dbo.wtfn_FormatNumber(stm.StatementID, 10) <= @BookMark
AND         (stm.MerchantID = @MerchantID)
AND         (stm.Status = @Status)
ORDER BY 'Bookmark' DESC

GO