EXEC [dbo].pts_CheckProc 'pts_Member_ListCustomers'
GO

CREATE PROCEDURE [dbo].pts_Member_ListCustomers
   @MemberID int
AS

SET NOCOUNT ON

SELECT      me.MemberID, 
         me.NameFirst, 
         me.NameLast, 
         me.Status, 
         me.Level, 
         me.Email, 
         me.EnrollDate
FROM Member AS me (NOLOCK)
WHERE (me.ReferralID = @MemberID)
 AND (me.IsRemoved = 0)
 AND (me.Status >= 1)
 AND (me.Status <= 2)
 AND (me.Level = 0)

ORDER BY   me.EnrollDate

GO