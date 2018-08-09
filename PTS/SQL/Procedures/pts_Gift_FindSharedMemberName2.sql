EXEC [dbo].pts_CheckProc 'pts_Gift_FindSharedMemberName2'
 GO

CREATE PROCEDURE [dbo].pts_Gift_FindSharedMemberName2 ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(me2.CompanyName, '') + dbo.wtfn_FormatNumber(gc.GiftID, 10) 'BookMark' ,
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
WHERE ISNULL(me2.CompanyName, '') LIKE @SearchText + '%'
AND ISNULL(me2.CompanyName, '') + dbo.wtfn_FormatNumber(gc.GiftID, 10) >= @BookMark
AND         (gc.MemberID = @MemberID)
AND         (gc.Member2ID = 0)
AND         (gc.Purpose = 'Shared')
ORDER BY 'Bookmark'

GO