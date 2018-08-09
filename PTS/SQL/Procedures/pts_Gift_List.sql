EXEC [dbo].pts_CheckProc 'pts_Gift_List'
GO

CREATE PROCEDURE [dbo].pts_Gift_List
   @Member2ID int
AS

SET NOCOUNT ON

SELECT      gc.GiftID, 
         me.CompanyName AS 'MemberName', 
         gc.GiftDate, 
         gc.ActiveDate, 
         gc.Amount, 
         gc.Purpose, 
         gc.Notes
FROM Gift AS gc (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (gc.MemberID = me.MemberID)
LEFT OUTER JOIN Member AS me2 (NOLOCK) ON (gc.Member2ID = me2.MemberID)
WHERE (gc.Member2ID = @Member2ID)

ORDER BY   gc.ActiveDate DESC

GO