EXEC [dbo].pts_CheckProc 'pts_Member_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_Member_ListGroup
   @GroupID int
AS

SET NOCOUNT ON

SELECT      me.MemberID, 
         me.NameFirst, 
         me.NameLast, 
         me.Status, 
         me.Role, 
         me.EnrollDate, 
         me.VisitDate
FROM Member AS me (NOLOCK)
WHERE (me.GroupID = @GroupID)
 AND (me.IsRemoved = 0)
 AND (me.Status > 0)
 AND (me.Status < 5)

ORDER BY   me.NameLast , me.NameFirst

GO