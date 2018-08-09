EXEC [dbo].pts_CheckProc 'pts_Org_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Org_ListMember
   @MemberID int
AS

SET         NOCOUNT ON

SELECT DISTINCT 
       oo.OrgID,
       oo.OrgName
FROM Org AS oo
JOIN OrgMember AS om ON (om.OrgID = oo.OrgID)
WHERE om.MemberID = @MemberID
ORDER BY oo.OrgName

GO