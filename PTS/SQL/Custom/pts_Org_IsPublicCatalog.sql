EXEC [dbo].pts_CheckProc 'pts_Org_IsPublicCatalog'
GO

CREATE PROCEDURE [dbo].pts_Org_IsPublicCatalog
   @CompanyID int,
   @MemberID int,
   @Public int OUTPUT  
AS

SET NOCOUNT ON

SELECT @Public = COUNT(*) 
FROM Org
LEFT OUTER JOIN (
	SELECT Org.OrgID, Org.Hierarchy
	FROM OrgMember
	JOIN Org ON (OrgMember.OrgID = Org.OrgID)
	WHERE Org.PrivateID = Org.OrgID
	AND OrgMember.MemberID = @MemberID
) AS private ON (private.OrgID = Org.PrivateID)
WHERE Org.CompanyID = @CompanyID
AND (Org.Status = 2 OR Org.Status = 3)
AND (Org.PrivateID = 0 OR Org.Hierarchy LIKE private.Hierarchy + '%')
AND (Org.IsCatalog = 1)
GO