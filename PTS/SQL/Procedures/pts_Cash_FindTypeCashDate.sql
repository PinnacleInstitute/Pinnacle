EXEC [dbo].pts_CheckProc 'pts_Cash_FindTypeCashDate'
 GO

CREATE PROCEDURE [dbo].pts_Cash_FindTypeCashDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FromDate datetime,
   @ToDate datetime,
   @CashType int,
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
            ISNULL(CONVERT(nvarchar(10), cas.CashDate, 112), '') + dbo.wtfn_FormatNumber(cas.CashID, 10) 'BookMark' ,
            cas.CashID 'CashID' ,
            cas.MemberID 'MemberID' ,
            cas.RefID 'RefID' ,
            cas.CashDate 'CashDate' ,
            cas.CashType 'CashType' ,
            cas.Amount 'Amount' ,
            cas.Note 'Note'
FROM Cash AS cas (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), cas.CashDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), cas.CashDate, 112), '') + dbo.wtfn_FormatNumber(cas.CashID, 10) <= @BookMark
AND         (cas.MemberID = @MemberID)
AND         (cas.CashDate >= @FromDate)
AND         (cas.CashDate <= @ToDate)
AND         (cas.CashType = @CashType)
ORDER BY 'Bookmark' DESC

GO