EXEC [dbo].pts_CheckProc 'pts_Member_ListReferral'
GO

CREATE PROCEDURE [dbo].pts_Member_ListReferral
   @ReferralID int
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
WHERE (me.ReferralID = @ReferralID)
 AND (me.IsRemoved = 0)

ORDER BY   me.EnrollDate

GO