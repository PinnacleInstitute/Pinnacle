EXEC [dbo].pts_CheckProc 'pts_Member_ListMasterAll'
GO

CREATE PROCEDURE [dbo].pts_Member_ListMasterAll
   @MasterID int
AS

SET NOCOUNT ON

SELECT      me.MemberID, 
         me.CompanyName, 
         me.VisitDate, 
         me.EnrollDate, 
         me.PaidDate, 
         me.Status, 
         me.StatusChange, 
         me.StatusDate, 
         me.GroupID, 
         me.Role, 
         me.IsIncluded, 
         me.IsMaster
FROM Member AS me (NOLOCK)
WHERE (me.MasterID = @MasterID)
 AND (me.IsRemoved = 0)

ORDER BY   me.GroupID , me.Role , me.CompanyName

GO