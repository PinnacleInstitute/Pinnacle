EXEC [dbo].pts_CheckProc 'pts_Company_MBCount'
 GO

--TEST --------------------------------
--DECLARE @Result varchar(1000)
--EXEC pts_Company_MBCount 13, @Result OUTPUT
--print @Result

CREATE PROCEDURE [dbo].pts_Company_MBCount ( 
	@CompanyID int ,
	@Result varchar(1000) OUTPUT
      )
AS

DECLARE @OrgTotal int,
	@OrgPublic int,
	@OrgPrivate int,
	@OrgSemiPrivate int,
	@CourseTotal int,
	@CoursePublic int,
	@CourseUsed int,
	@CourseUnused int,
	@CourseTrainer int,
	@AssessTotal int,
	@AssessActive int,
	@AssessInactive int,
	@SurveyTotal int,
	@SurveyCompleted int,
	@SurveyPending int,
	@SurveyInactive int,
	@SuggestTotal int,
	@SuggestNew  int,
	@SuggestReplied int,
	@SuggestAccepted int,
	@SuggestRewarded int,
	@Expectation0 int,
	@Expectation1 int

SET @OrgTotal = 0
SET @OrgPublic = 0
SET @OrgPrivate = 0
SET @OrgSemiPrivate = 0
SET @CourseTotal = 0
SET @CoursePublic = 0
SET @CourseUsed = 0
SET @CourseUnused = 0
SET @CourseTrainer = 0
SET @AssessTotal = 0
SET @AssessActive = 0
SET @AssessInactive = 0
SET @SurveyTotal = 0
SET @SurveyCompleted = 0
SET @SurveyPending = 0
SET @SurveyInactive = 0
SET @SuggestTotal = 0
SET @SuggestNew  = 0
SET @SuggestReplied = 0
SET @SuggestAccepted = 0
SET @SuggestRewarded = 0
SET @Expectation0 = 0
SET @Expectation1 = 0

-----------------------------------------------------------------
-- Get Members
-----------------------------------------------------------------
-- Member Counts come from ReportMembership and ReportVisit

-----------------------------------------------------------------
-- Get Orgs
-----------------------------------------------------------------
SELECT @OrgTotal = COUNT(*)
FROM Org WHERE CompanyID = @CompanyID 

SELECT @OrgPublic = COUNT(*)
FROM Org WHERE CompanyID = @CompanyID AND IsPublic = 1 AND PrivateID = 0

SELECT @OrgPrivate = COUNT(*)
FROM Org WHERE CompanyID = @CompanyID AND IsPublic = 0

SELECT @OrgSemiPrivate = COUNT(*)
FROM Org WHERE CompanyID = @CompanyID AND IsPublic = 1 AND PrivateID != 0

--SELECT @Expectation0 = COUNT(*)
--FROM Org WHERE CompanyID = @CompanyID AND Expectation = ''

--SELECT @Expectation1 = COUNT(*)
--FROM Org WHERE CompanyID = @CompanyID AND Expectation != ''

-----------------------------------------------------------------
-- Get Courses
-----------------------------------------------------------------
SELECT @CourseTotal = COUNT(*)
FROM Course WHERE CompanyID = @CompanyID

SELECT @CoursePublic = COUNT(*)
FROM (
	SELECT DISTINCT oc.CourseID
	FROM OrgCourse AS oc
	JOIN Org AS og ON oc.OrgID = og.OrgID
	JOIN Course AS co ON oc.CourseID = co.CourseID
	WHERE og.CompanyID = @CompanyID
	AND co.CompanyID =  0
) AS tmp

IF @CourseTotal > 0
BEGIN
	SELECT @CourseUsed = COUNT(*)
	FROM (
		SELECT DISTINCT oc.CourseID
		FROM OrgCourse AS oc
		JOIN Org AS og ON oc.OrgID = og.OrgID
		JOIN Course AS co ON oc.CourseID = co.CourseID
		WHERE og.CompanyID = @CompanyID
		AND co.CompanyID = @CompanyID
	) AS tmp

	SELECT @CourseUnused = COUNT(*)
	FROM Course AS co
	WHERE CompanyID = @CompanyID
	AND co.CourseID NOT IN (
		SELECT oc.CourseID
		FROM OrgCourse AS oc
		JOIN Org AS og ON oc.OrgID = og.OrgID
		WHERE og.CompanyID = @CompanyID
	)

	SELECT @CourseTrainer = COUNT(*)
	FROM (
		SELECT DISTINCT TrainerID
		FROM Course
		WHERE CompanyID = @CompanyID
	) AS tmp
END
-----------------------------------------------------------------
-- Get Assessments
-----------------------------------------------------------------
SELECT @AssessTotal = COUNT(*)
FROM Assessment WHERE CompanyID = @CompanyID

IF @AssessTotal > 0
BEGIN
	SELECT @AssessActive = COUNT(*)
	FROM Assessment WHERE CompanyID = @CompanyID AND Status = 2

	SELECT @AssessInactive = COUNT(*)
	FROM Assessment WHERE CompanyID = @CompanyID AND Status != 2
END
-----------------------------------------------------------------
-- Get Surveys
-----------------------------------------------------------------
SELECT @SurveyTotal = COUNT(*)
FROM Survey AS su 
JOIN Org as og ON su.OrgID = og.OrgID
WHERE og.CompanyID = @CompanyID

IF @SurveyTotal > 0
BEGIN
	SELECT @SurveyCompleted = COUNT(*)
	FROM Survey AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND CURRENT_TIMESTAMP >= su.EndDate

	SELECT @SurveyPending = COUNT(*)
	FROM Survey AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND su.Status = 1
	AND CURRENT_TIMESTAMP >= su.StartDate AND CURRENT_TIMESTAMP <= su.EndDate

	SELECT @SurveyInactive = COUNT(*)
	FROM Survey AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND su.Status != 1
END
-----------------------------------------------------------------
-- Get Suggestions
-----------------------------------------------------------------
SELECT @SuggestTotal = COUNT(*)
FROM Suggestion AS su 
JOIN Org as og ON su.OrgID = og.OrgID
WHERE og.CompanyID = @CompanyID 

IF @SuggestTotal > 0
BEGIN
	SELECT @SuggestNew = COUNT(*)
	FROM Suggestion AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND su.Status = 1

	SELECT @SuggestReplied = COUNT(*)
	FROM Suggestion AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND su.Status > 1

	SELECT @SuggestAccepted = COUNT(*)
	FROM Suggestion AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND su.Status = 3

	SELECT @SuggestRewarded = COUNT(*)
	FROM Suggestion AS su 
	JOIN Org as og ON su.OrgID = og.OrgID
	WHERE og.CompanyID = @CompanyID AND su.Status = 4
END

SET @Result = '<PTSMB ' + 
'orgtotal="'        + CAST(@OrgTotal AS VARCHAR(10)) + '" ' +
'orgpublic="'       + CAST(@OrgPublic AS VARCHAR(10)) + '" ' +
'orgprivate="'      + CAST(@OrgPrivate AS VARCHAR(10)) + '" ' +
'orgsemiprivate="'  + CAST(@OrgSemiPrivate AS VARCHAR(10)) + '" ' +
'coursetotal="'     + CAST(@CourseTotal AS VARCHAR(10)) + '" ' +
'coursepublic="'    + CAST(@CoursePublic AS VARCHAR(10)) + '" ' +
'courseused="'      + CAST(@CourseUsed AS VARCHAR(10)) + '" ' +
'courseunused="'    + CAST(@CourseUnused AS VARCHAR(10)) + '" ' +
'coursetrainer="'   + CAST(@CourseTrainer AS VARCHAR(10)) + '" ' +
'assesstotal="'     + CAST(@AssessTotal AS VARCHAR(10)) + '" ' +
'assessactive="'    + CAST(@AssessActive AS VARCHAR(10)) + '" ' +
'assessinactive="'  + CAST(@AssessInactive AS VARCHAR(10)) + '" ' +
'surveytotal="'     + CAST(@SurveyTotal AS VARCHAR(10)) + '" ' +
'surveycompleted="' + CAST(@SurveyCompleted AS VARCHAR(10)) + '" ' +
'surveypending="'   + CAST(@SurveyPending AS VARCHAR(10)) + '" ' +
'surveyinactive="'  + CAST(@SurveyInactive AS VARCHAR(10)) + '" ' +
'suggesttotal="'    + CAST(@SuggestTotal AS VARCHAR(10)) + '" ' +
'suggestnew="'      + CAST(@SuggestNew AS VARCHAR(10)) + '" ' +
'suggestreplied="'  + CAST(@SuggestReplied AS VARCHAR(10)) + '" ' +
'suggestaccepted="' + CAST(@SuggestAccepted AS VARCHAR(10)) + '" ' +
'suggestrewarded="' + CAST(@SuggestRewarded AS VARCHAR(10)) + '" ' +
'expectation1="'    + CAST(@Expectation1 AS VARCHAR(10)) + '" ' +
'expectation0="'    + CAST(@Expectation0 AS VARCHAR(10)) + '"/> '

GO