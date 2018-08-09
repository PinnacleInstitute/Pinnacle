EXEC [dbo].pts_CheckProc 'pts_Prepaid_FindPayDate'
 GO

CREATE PROCEDURE [dbo].pts_Prepaid_FindPayDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FromDate datetime,
   @ToDate datetime,
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
            ISNULL(CONVERT(nvarchar(10), pre.PayDate, 112), '') + dbo.wtfn_FormatNumber(pre.PrepaidID, 10) 'BookMark' ,
            pre.PrepaidID 'PrepaidID' ,
            pre.MemberID 'MemberID' ,
            pre.RefID 'RefID' ,
            pre.PayDate 'PayDate' ,
            pre.PayType 'PayType' ,
            pre.Amount 'Amount' ,
            pre.Note 'Note' ,
            pre.BV 'BV' ,
            pre.Bonus 'Bonus'
FROM Prepaid AS pre (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), pre.PayDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), pre.PayDate, 112), '') + dbo.wtfn_FormatNumber(pre.PrepaidID, 10) <= @BookMark
AND         (pre.MemberID = @MemberID)
AND         (pre.PayDate >= @FromDate)
AND         (pre.PayDate <= @ToDate)
ORDER BY 'Bookmark' DESC

GO