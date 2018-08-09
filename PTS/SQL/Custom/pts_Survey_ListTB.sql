EXEC [dbo].pts_CheckProc 'pts_Survey_ListTB'
GO

CREATE PROCEDURE [dbo].pts_Survey_ListTB ( 
	@MemberID int, 
	@VisitDate datetime,
	@Status int
)
AS
SET NOCOUNT ON

DECLARE @CompanyID int
SELECT @CompanyID = CompanyID FROM Member WHERE MemberID = @MemberID

-- Taken Surveys
IF @Status = 1
BEGIN
	SELECT DISTINCT su.SurveyID,su.OrgID,su.SurveyName,su.Description,su.StartDate,su.EndDate,su.Status,org.OrgName
	FROM  SurveyAnswer AS sa
	JOIN  SurveyQuestion AS sq ON sa.SurveyQuestionID = sq.SurveyQuestionID
	JOIN Survey AS su ON su.SurveyID = sq.SurveyID
	JOIN Org AS org ON su.OrgID = org.OrgID
	WHERE sa.MemberID = @MemberID
END

-- Untaken Surveys
IF @Status = 2
BEGIN
	SELECT DISTINCT su.SurveyID,su.OrgID,su.SurveyName,su.Description,su.StartDate,su.EndDate,su.Status,org.OrgName
	FROM   (
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
	) AS tmp
	JOIN Survey AS su ON (su.OrgID = tmp.OrgID)
	JOIN Org as org ON (su.OrgID = org.OrgID)
	WHERE su.Status = 1
	AND NOT EXISTS (	
		SELECT SurveyAnswerID
		FROM SurveyAnswer AS sa
		JOIN SurveyQuestion AS sq ON sa.SurveyQuestionID = sq.SurveyQuestionID 
		WHERE sq.SurveyID = su.SurveyID AND MemberID = @MemberID
		)
END

-- New Surveys for a date
IF @Status = 3 OR @Status = 4
BEGIN
	SELECT DISTINCT su.SurveyID,su.OrgID,su.SurveyName,su.Description,su.StartDate,su.EndDate,su.Status,org.OrgName
	FROM (
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
	) AS tmp
	JOIN Survey AS su ON (su.OrgID = tmp.OrgID)
	JOIN Org as org ON (su.OrgID = org.OrgID)
	WHERE su.Status = 1 AND su.StartDate > @VisitDate
	AND NOT EXISTS (
		SELECT SurveyAnswerID
		FROM SurveyAnswer AS sa
		JOIN SurveyQuestion AS sq ON sa.SurveyQuestionID = sq.SurveyQuestionID 
		WHERE sq.SurveyID = su.SurveyID AND MemberID = @MemberID
		)
END

GO

