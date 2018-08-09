EXEC [dbo].pts_CheckProc 'pts_Statement_FindMerchantAmount'
 GO

CREATE PROCEDURE [dbo].pts_Statement_FindMerchantAmount ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (30),
   @MaxRows tinyint OUTPUT,
   @MerchantID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(15), stm.Amount), '') + dbo.wtfn_FormatNumber(stm.StatementID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(15), stm.Amount), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(15), stm.Amount), '') + dbo.wtfn_FormatNumber(stm.StatementID, 10) >= @BookMark
AND         (stm.MerchantID = @MerchantID)
ORDER BY 'Bookmark'

GO