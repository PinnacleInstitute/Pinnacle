EXEC [dbo].pts_CheckProc 'pts_Survey_ListActive'
GO

CREATE PROCEDURE [dbo].pts_Survey_ListActive
   @CompanyID int ,
   @MemberID int
AS

DECLARE   @mNow datetime

SET         NOCOUNT ON

SET      @mNow = GETDATE()
SELECT   su.SurveyID, su.orgid,
         su.SurveyName, 
         og.OrgName AS 'OrgName', 
         su.Description, 
         su.Status, 
         su.StartDate, 
         su.EndDate
FROM     Survey AS su (NOLOCK)
         LEFT OUTER JOIN Org AS og (NOLOCK) ON (su.OrgID = og.OrgID)
WHERE   su.OrgID IN (
	SELECT Org.OrgID
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
)
AND (su.Status = 1)
AND ((su.StartDate = 0)
OR  (dbo.wtfn_DateOnly(su.StartDate) <= dbo.wtfn_DateOnly(@mNow)))
AND ((su.EndDate = 0)
OR  (dbo.wtfn_DateOnly(su.EndDate) >= dbo.wtfn_DateOnly(@mNow)))

ORDER BY   su.StartDate

GO
