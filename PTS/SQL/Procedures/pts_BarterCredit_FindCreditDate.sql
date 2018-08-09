EXEC [dbo].pts_CheckProc 'pts_BarterCredit_FindCreditDate'
 GO

CREATE PROCEDURE [dbo].pts_BarterCredit_FindCreditDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
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
            ISNULL(CONVERT(nvarchar(10), bac.CreditDate, 112), '') + dbo.wtfn_FormatNumber(bac.BarterCreditID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), bac.CreditDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), bac.CreditDate, 112), '') + dbo.wtfn_FormatNumber(bac.BarterCreditID, 10) <= @BookMark
AND         (bac.OwnerType = @OwnerType)
AND         (bac.OwnerID = @OwnerID)
ORDER BY 'Bookmark' DESC

GO