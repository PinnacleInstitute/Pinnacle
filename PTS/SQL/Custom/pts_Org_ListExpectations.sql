EXEC [dbo].pts_CheckProc 'pts_Org_ListExpectations'
GO

--EXEC pts_Org_ListExpectations 13, 84

CREATE PROCEDURE [dbo].pts_Org_ListExpectations
   @CompanyID int,
   @MemberID int  
AS

SET         NOCOUNT ON

SELECT DISTINCT 
       Org.OrgID, 
       Org.OrgName,
       Org.Expectation
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
AND Org.Expectation != ''
ORDER BY Org.OrgName

GO