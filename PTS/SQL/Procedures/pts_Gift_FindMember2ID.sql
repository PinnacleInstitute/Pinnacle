EXEC [dbo].pts_CheckProc 'pts_Gift_FindMember2ID'
 GO

CREATE PROCEDURE [dbo].pts_Gift_FindMember2ID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), gc.Member2ID), '') + dbo.wtfn_FormatNumber(gc.GiftID, 10) 'BookMark' ,
            gc.GiftID 'GiftID' ,
            gc.MemberID 'MemberID' ,
            gc.PaymentID 'PaymentID' ,
            gc.Member2ID 'Member2ID' ,
            me.CompanyName 'MemberName' ,
            me2.CompanyName 'MemberName2' ,
            gc.GiftDate 'GiftDate' ,
            gc.ActiveDate 'ActiveDate' ,
            gc.Amount 'Amount' ,
            gc.Purpose 'Purpose' ,
            gc.Notes 'Notes'
FROM Gift AS gc (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (gc.MemberID = me.MemberID)
LEFT OUTER JOIN Member AS me2 (NOLOCK) ON (gc.Member2ID = me2.MemberID)
WHERE ISNULL(CONVERT(nvarchar(10), gc.Member2ID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), gc.Member2ID), '') + dbo.wtfn_FormatNumber(gc.GiftID, 10) >= @BookMark
AND         (gc.MemberID = @MemberID)
ORDER BY 'Bookmark'

GO