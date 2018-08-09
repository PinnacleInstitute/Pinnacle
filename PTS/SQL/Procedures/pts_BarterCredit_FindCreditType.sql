EXEC [dbo].pts_CheckProc 'pts_BarterCredit_FindCreditType'
 GO

CREATE PROCEDURE [dbo].pts_BarterCredit_FindCreditType ( 
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
            ISNULL(CONVERT(nvarchar(10), bac.CreditType), '') + dbo.wtfn_FormatNumber(bac.BarterCreditID, 10) 'BookMark' ,
            bac.BarterCreditID 'BarterCreditID' ,
            bac.OwnerType 'OwnerType' ,
            bac.OwnerID 'OwnerID' ,
            bac.BarterAdID 'BarterAdID' ,
            bac.CreditDate 'CreditDate' ,
            bac.Amount 'Amount' ,
            bac.Status 'Status' ,
            bac.CreditType 'CreditType' ,
            bac.StartDate 'StartDate' ,
            bac.EndDate 'EndDate' ,
            bac.Reference 'Reference' ,
            bac.Notes 'Notes'
FROM BarterCredit AS bac (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), bac.CreditType), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bac.CreditType), '') + dbo.wtfn_FormatNumber(bac.BarterCreditID, 10) >= @BookMark
AND         (bac.OwnerType = @OwnerType)
AND         (bac.OwnerID = @OwnerID)
ORDER BY 'Bookmark'

GO