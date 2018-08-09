EXEC [dbo].pts_CheckProc 'pts_Member_TBCount'
 GO

--TEST-----------------------------------------------
--DECLARE @Result varchar(1000)
--EXEC pts_Member_TBCount 84, '1/1/05', @Result OUTPUT
--PRINT @Result

CREATE PROCEDURE [dbo].pts_Member_TBCount ( 
	@MemberID int ,
	@VisitDate datetime ,
	@Result varchar(1000) OUTPUT
      )
AS

DECLARE @CompanyCourseVisit int,
	@CompanyCourse30 int,
	@CompanyCourseTotal int,
	@CompanyCourseRegister int,
	@CompanyCourseUnregister int,
	@PublicCourseRegister int,
	@PublicCoursevisit int,
	@PublicCourse30 int,
	@CompanyAssessmentVisit int,
	@CompanyAssessment30 int,
	@CompanyAssessmentTotal int,
	@CompanyAssessmentTaken int,
	@PublicAssessmentVisit int,
	@PublicAssessment30 int,
	@PublicAssessmentTaken int,
	@SurveyVisit int,
	@Survey30 int,
	@SurveyTaken int,
	@SurveyUntaken int,
	@SuggestionSubmitted int,
	@SuggestionReplied int,
	@SuggestionVisit int,
	@Suggestion30 int,
	@MessagePosted int,
	@MessageReplied int,
	@MessageVisit int,
	@Message30 int,
	@FavoriteCompany int,
	@FavoritePublic int,
	@FavoriteChat int,
	@FavoriteForum int,
	@FavoriteCCVisit int,
	@FavoriteCC30 int,
	@FavoritePCVisit int,
	@FavoritePC30 int,
	@FavoriteMPVisit int,
	@FavoriteMP30 int,
	@FavoriteMRVisit int,
	@FavoriteMR30 int,
	@Expectation int,
	@GoalTotal int,
	@GoalDeclare int,
	@GoalCommit int,
	@GoalComplete int,
	@GoalEarly int,
	@GoalOntime int,
	@GoalLate int

SET @CompanyCourseVisit = 0
SET @CompanyCourse30 = 0
SET @CompanyCourseTotal = 0
SET @CompanyCourseRegister = 0
SET @CompanyCourseUnregister = 0
SET @PublicCourseRegister = 0
SET @PublicCoursevisit = 0
SET @PublicCourse30 = 0
SET @CompanyAssessmentVisit = 0
SET @CompanyAssessment30 = 0
SET @CompanyAssessmentTotal = 0
SET @CompanyAssessmentTaken = 0
SET @PublicAssessmentVisit = 0
SET @PublicAssessment30 = 0
SET @PublicAssessmentTaken = 0
SET @SurveyVisit = 0
SET @Survey30 = 0
SET @SurveyTaken = 0
SET @SurveyUntaken = 0
SET @SuggestionSubmitted = 0
SET @SuggestionReplied = 0
SET @SuggestionVisit = 0
SET @Suggestion30 = 0
SET @MessagePosted = 0
SET @MessageReplied = 0
SET @MessageVisit = 0
SET @Message30 = 0
SET @FavoriteCompany = 0
SET @FavoritePublic = 0
SET @FavoriteChat = 0
SET @FavoriteForum = 0
SET @FavoriteCCVisit = 0
SET @FavoriteCC30 = 0
SET @FavoritePCVisit = 0
SET @FavoritePC30 = 0
SET @FavoriteMPVisit = 0
SET @FavoriteMP30 = 0
SET @FavoriteMRVisit = 0
SET @FavoriteMR30 = 0
SET @Expectation = 0
SET @GoalTotal = 0
SET @GoalDeclare = 0
SET @GoalCommit = 0
SET @GoalComplete = 0
SET @GoalEarly = 0
SET @GoalOntime = 0
SET @GoalLate = 0

DECLARE	@CompanyID int,
	@AuthUserID int,
	@30Date datetime,
	@cnt int

--fetch the current date
SET @30Date = DATEADD(day,-30,CURRENT_TIMESTAMP)

--fetch the member data
SELECT 	@AuthUserID = AuthUserID,
	@CompanyID = CompanyID
FROM Member WHERE MemberID = @MemberID

--fetch the list of orgs in which this member participates into a temp table
DECLARE @CompanyFolders TABLE( OrgID int )

-----------------------------------------------------------------
-- Get Accessible Company Folders for Company Courses and Surveys
-----------------------------------------------------------------
INSERT INTO @CompanyFolders 
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

-----------------------------------------------------------------
-- Get Company Courses
-----------------------------------------------------------------
------------------------------------------------	
-- c. Count of total accessible company courses
------------------------------------------------
SELECT @CompanyCourseTotal = COUNT(*)
FROM (
	SELECT DISTINCT co.CourseID
	FROM   @CompanyFolders AS tmp
	LEFT   OUTER JOIN OrgCourse AS oco ON (oco.OrgID = tmp.OrgID)
	LEFT   OUTER JOIN Course AS co ON (co.CourseID = oco.CourseID)
	WHERE  co.Status = 3
) AS tmpc

IF @CompanyCourseTotal > 0
BEGIN
--	-----------------------------------------------
--	-- a. Count of new company courses since last visit
--	-----------------------------------------------
	SELECT @CompanyCourseVisit = COUNT(*)
	FROM (
	SELECT DISTINCT co.CourseID
	FROM   @CompanyFolders AS tmp
	LEFT   OUTER JOIN OrgCourse AS oco ON (oco.OrgID = tmp.OrgID)
	LEFT   OUTER JOIN Course AS co ON (co.CourseID = oco.CourseID)
	WHERE  co.Status = 3 AND co.CourseDate > @VisitDate
	) AS tmpc
	
--	------------------------------------------------
--	-- b. Count of new company courses in last 30 days
--	------------------------------------------------
	SELECT @CompanyCourse30 = COUNT(*)
	FROM (
		SELECT DISTINCT co.CourseID
		FROM   @CompanyFolders AS tmp
		LEFT   OUTER JOIN OrgCourse AS oco ON (oco.OrgID = tmp.OrgID)
		LEFT   OUTER JOIN Course AS co ON (co.CourseID = oco.CourseID)
		WHERE   co.Status = 3 AND co.CourseDate > @30Date
	) AS tmpc
	
--	------------------------------------------------	
--	-- d. Count of registered accessible company courses
--	------------------------------------------------
	SELECT @CompanyCourseRegister =	COUNT(*)
	FROM  Session
	WHERE MemberID = @MemberID AND OrgCourseID > 0 AND IsInactive = 0
	
--	------------------------------------------------	
--	-- e. Count of unregistered accessible company courses
--	------------------------------------------------
	SELECT @CompanyCourseUnregister = COUNT(*)
	FROM (
		SELECT DISTINCT co.CourseID
		FROM   @CompanyFolders AS tmp
		LEFT   OUTER JOIN OrgCourse AS oco ON (oco.OrgID = tmp.OrgID)
		LEFT   OUTER JOIN Session AS se ON (se.OrgCourseID = oco.OrgCourseID AND se.MemberID = @MemberID)
		LEFT   OUTER JOIN Course AS co ON (co.CourseID = oco.CourseID)
		WHERE  co.Status = 3 AND se.SessionID IS NULL
	) AS tmpc
END	
-----------------------------------------------------------------
-- Get Public Courses
-----------------------------------------------------------------
------------------------------------------------
-- f. Count of Registered public courses
------------------------------------------------
SELECT @PublicCourseRegister = COUNT(*)
FROM   Session AS se
WHERE  se.MemberID = @MemberID AND se.OrgCourseID = 0 AND se.IsInactive = 0

------------------------------------------------	
-- g. Count of new courses since last visit
------------------------------------------------
SELECT @PublicCoursevisit = COUNT(*)
FROM   Course
WHERE  Status = 3 AND CompanyID = 0 AND CourseDate > @VisitDate

------------------------------------------------	
-- h. Count of new courses in last 30 days
------------------------------------------------
SELECT @PublicCourse30 = COUNT(*)
FROM   Course
WHERE  Status = 3 AND CompanyID = 0 AND  CourseDate > @30Date

-----------------------------------------------------------------
-- Get Company Assessments
-----------------------------------------------------------------
------------------------------------------------
-- k. Count of Total company assessments
------------------------------------------------
SELECT @CompanyAssessmentTotal = COUNT(*)
FROM   Assessment
WHERE  CompanyID = @CompanyID AND Status = 2

IF @CompanyAssessmentTotal > 0
BEGIN
--	------------------------------------------------
--	-- i. Count of new company assessments since last visit
--	------------------------------------------------
	SELECT @CompanyAssessmentvisit = COUNT(*)
	FROM   Assessment
	WHERE  CompanyID = @CompanyID AND Status = 2 AND AssessDate > @VisitDate
	
--	------------------------------------------------
--	-- j. Count of new company assessments in last 30 days
--	------------------------------------------------
	SELECT @CompanyAssessment30 = COUNT(*)
	FROM   Assessment WHERE  CompanyID = @CompanyID AND Status = 2 AND AssessDate > @30Date
	
--	------------------------------------------------
--	-- l. Count of taken company assessments
--	------------------------------------------------
	SELECT @CompanyAssessmentTaken = COUNT(*)
	FROM   MemberAssess AS ma
	LEFT   OUTER JOIN Assessment AS assm ON (assm.AssessmentID = ma.AssessmentID)
	WHERE  ma.MemberID = @MemberID AND assm.CompanyID = @CompanyID
END	
-----------------------------------------------------------------
-- Get Public Assessments
-----------------------------------------------------------------
------------------------------------------------
-- m. Count of new public assessments since last visit
------------------------------------------------
SELECT @PublicAssessmentVisit = COUNT(*)
FROM   Assessment
WHERE  AssessDate > @VisitDate AND CompanyID = 0 AND Status = 2

------------------------------------------------
-- n. Count of new public assessments in last 30 days
------------------------------------------------
SELECT @PublicAssessment30 = COUNT(*)
FROM   Assessment
WHERE  AssessDate > @30Date AND CompanyID = 0 AND Status = 2

------------------------------------------------
-- o. Count of Registered public assessments
------------------------------------------------
SELECT @PublicAssessmentTaken = COUNT(*)
FROM   MemberAssess AS ma
LEFT   OUTER JOIN Assessment AS assm ON (assm.AssessmentID = ma.AssessmentID)
WHERE  ma.MemberID = @MemberID AND assm.CompanyID = 0

-----------------------------------------------------------------
-- Get Surveys
-----------------------------------------------------------------
SELECT @cnt = COUNT(*)
FROM Survey AS su 
JOIN Org as og ON su.OrgID = og.OrgID
WHERE og.CompanyID = @CompanyID

IF @cnt > 0
BEGIN
--	------------------------------------------------
--	-- p. Count of new surveys since last visit
--	------------------------------------------------
	SELECT @SurveyVisit = COUNT(*)
	FROM (
		SELECT DISTINCT su.SurveyID
		FROM   @CompanyFolders AS tmp
		LEFT   OUTER JOIN Survey AS su ON (su.OrgID = tmp.OrgID)
		WHERE  su.Status = 1 AND su.StartDate > @VisitDate
	) tmps
--	------------------------------------------------
--	-- q. Count of new surveys in last 30 days
--	------------------------------------------------
	SELECT @Survey30 = COUNT(*)
	FROM (
		SELECT DISTINCT su.SurveyID
		FROM   @CompanyFolders AS tmp
		LEFT   OUTER JOIN Survey AS su ON (su.OrgID = tmp.OrgID)
		WHERE  su.Status = 1 AND su.StartDate > @30Date
	) tmps
	
--	------------------------------------------------
--	-- s. Count of untaken surveys
--	------------------------------------------------
	SELECT @SurveyUntaken = COUNT(*)
	FROM (
		SELECT DISTINCT su.SurveyID
		FROM   @CompanyFolders AS tmp
		LEFT   OUTER JOIN Survey AS su ON (su.OrgID = tmp.OrgID)
		WHERE  su.Status = 1
		AND NOT EXISTS (	
			SELECT SurveyAnswerID
			FROM SurveyAnswer AS sa
			JOIN SurveyQuestion AS sq ON sa.SurveyQuestionID = sq.SurveyQuestionID 
			WHERE sq.SurveyID = su.SurveyID AND MemberID = @MemberID
			)
	) tmps
END
------------------------------------------------
-- r. Count of all taken surveys
------------------------------------------------
SELECT @SurveyTaken = COUNT(*)
FROM (
	SELECT DISTINCT sq.SurveyID
	FROM  SurveyAnswer AS sa
	JOIN  SurveyQuestion AS sq ON (sa.SurveyQuestionID = sq.SurveyQuestionID)
	WHERE sa.MemberID = @MemberID
) tmp

-----------------------------------------------------------------
-- Get Submitted Suggestions
-----------------------------------------------------------------
------------------------------------------------
-- t. Count of total suggestions
------------------------------------------------
SELECT @SuggestionSubmitted = COUNT(*)
FROM   Suggestion
WHERE  MemberID = @MemberID

-----------------------------------------------------------------
-- Get Replied Suggestions
-----------------------------------------------------------------
IF @SuggestionSubmitted > 0
BEGIN
--	------------------------------------------------
--	-- u. Count of read suggestions
--	------------------------------------------------
	SELECT @SuggestionReplied = COUNT(*)
	FROM   Suggestion
	WHERE  MemberID = @MemberID AND Status > 1
	
--	------------------------------------------------
--	-- v. Count of read suggestions since last visit
--	------------------------------------------------
	SELECT @SuggestionVisit = COUNT(*)
	FROM   Suggestion
	WHERE  MemberID = @MemberID AND Status > 1 AND ChangeDate > @VisitDate
	
--	------------------------------------------------
--	-- w. Count of read suggestions in last 30 days
--	------------------------------------------------
	SELECT @Suggestion30 = COUNT(*)
	FROM   Suggestion
	WHERE  MemberID = @MemberID AND Status > 1 AND ChangeDate > @30Date
END
-----------------------------------------------------------------
-- Get Posted Messages
-----------------------------------------------------------------
------------------------------------------------
-- x. Count of Total posted messages
------------------------------------------------
SELECT @MessagePosted = COUNT(*)
FROM   Message AS msg
LEFT   OUTER JOIN BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
WHERE  bu.AuthUserID = @AuthUserID

-----------------------------------------------------------------
-- Get Replied Messages
-----------------------------------------------------------------
IF @MessagePosted > 0
BEGIN
--	------------------------------------------------
--	-- w. Count of total messages replied to
--	------------------------------------------------
	SELECT @MessageReplied = COUNT(*)
	FROM   Message AS msg
	JOIN   Message AS rmsg ON (rmsg.MessageID = msg.ParentID)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID

--	------------------------------------------------
--	-- w. Count of messages replied to since last visit
--	------------------------------------------------
	SELECT @MessageVisit = COUNT(*)
	FROM   Message AS msg
	JOIN   Message AS rmsg ON (rmsg.MessageID = msg.ParentID)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @VisitDate

--	------------------------------------------------
--	-- w. Count of messages replied to in last 30 days
--	------------------------------------------------
	SELECT @Message30 = COUNT(*)
	FROM   Message AS msg
	JOIN   Message AS rmsg ON (rmsg.MessageID = msg.ParentID)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @30Date
END
-----------------------------------------------------------------
-- Get Favorites
-----------------------------------------------------------------
------------------------------------------------
-- x. Count of favorites company folders
------------------------------------------------
SELECT @FavoriteCompany = COUNT(*)
FROM   Favorite
WHERE  MemberID = @MemberID AND RefType = 2

------------------------------------------------
-- y. Count of favorites public folders
------------------------------------------------
SELECT @FavoritePublic = COUNT(*)
FROM   Favorite
WHERE  MemberID = @MemberID AND RefType = 1

------------------------------------------------
-- z. Count of favorites conference rooms
------------------------------------------------
SELECT @FavoriteChat = COUNT(*)
FROM   Favorite
WHERE  MemberID = @MemberID AND RefType = 3

------------------------------------------------
-- aa. Count of favorites discussion boards
------------------------------------------------
SELECT @FavoriteForum = COUNT(*)
FROM   Favorite
WHERE  MemberID = @MemberID AND RefType = 4

IF @FavoriteCompany > 0
BEGIN
--	------------------------------------------------
--	-- Count of favorite new company courses since last visit
--	------------------------------------------------
	SELECT @FavoriteCCVisit = COUNT(*)
	FROM   OrgCourse AS oco
	JOIN   Course AS co ON (co.CourseID = oco.CourseID)
	JOIN   Favorite AS f ON (f.RefID = oco.OrgID AND f.RefType = 2)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID AND co.CourseDate > @VisitDate
	
--	------------------------------------------------
--	-- Count of favorite new company courses with last 30 days
--	------------------------------------------------
	SELECT @FavoriteCC30 = COUNT(*)
	FROM   OrgCourse AS oco
	JOIN   Course AS co ON (co.CourseID = oco.CourseID)
	JOIN   Favorite AS f ON (f.RefID = oco.OrgID AND f.RefType = 2)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID AND co.CourseDate > @30Date
END

IF @FavoritePublic > 0
BEGIN
--	------------------------------------------------
--	-- Count of favorite new public courses since last visit
--	------------------------------------------------
	SELECT @FavoritePCVisit = COUNT(*)
	FROM   Course AS co 
	JOIN   CourseCategory AS cc ON co.CourseCategoryID = cc.CourseCategoryID
	JOIN   Favorite AS f ON (f.RefID = cc.CourseCategoryID AND f.RefType = 1)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID AND co.CourseDate > @VisitDate
	
--	------------------------------------------------
--	-- Count of favorite new public courses with last 30 days
--	------------------------------------------------
	SELECT @FavoritePC30 = COUNT(*)
	FROM   Course AS co 
	JOIN   CourseCategory AS cc ON co.CourseCategoryID = cc.CourseCategoryID
	JOIN   Favorite AS f ON (f.RefID = cc.CourseCategoryID AND f.RefType = 1)
	WHERE  co.Status = 3 AND f.MemberID = @MemberID AND co.CourseDate > @30Date
END

IF @FavoriteForum > 0
BEGIN
--	--	------------------------------------------------
--	--	-- Count of favorite new posted messages since last visit
--	--	------------------------------------------------
	SELECT @FavoriteMPVisit = COUNT(*)
	FROM   Message AS msg
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @VisitDate
	
--	--	------------------------------------------------
--	--	-- Count of favorite new posted messages with last 30 days
--	--	------------------------------------------------
	SELECT @FavoriteMP30 = COUNT(*)
	FROM   Message AS msg
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @30Date
	
--	--	------------------------------------------------
--	--	-- Count of favorite new replied to messages since last visit
--	--	------------------------------------------------
	SELECT @FavoriteMRVisit = COUNT(*)
	FROM   Message AS msg
	JOIN   Message AS rmsg ON (rmsg.MessageID = msg.ParentID)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @VisitDate
	
--	-----------------------------------------------
--	-- Count of favorite new replied to messages with last 30 days
--	------------------------------------------------
	SELECT @FavoriteMR30 = COUNT(*)
	FROM   Message AS msg
	JOIN   Message AS rmsg ON (rmsg.MessageID = msg.ParentID)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @30Date
END

--SELECT @Expectation = COUNT(*)
--FROM (
--	SELECT DISTINCT og.OrgID
--	FROM   @CompanyFolders AS tmp
--	LEFT   OUTER JOIN Org AS og ON (og.OrgID = tmp.OrgID)
--	WHERE  og.Expectation != ''
--) tmps

SELECT @GoalTotal = COUNT(*) FROM Goal 
Where MemberID = @MemberID AND Status < 4

IF @GoalTotal > 0
BEGIN
	SELECT @GoalDeclare = COUNT(*) FROM Goal
	Where MemberID = @MemberID AND Status = 1

	SELECT @GoalCommit = COUNT(*) FROM Goal
	Where MemberID = @MemberID AND Status = 2

	SELECT @GoalComplete = COUNT(*) FROM Goal
	Where MemberID = @MemberID AND Status = 3

	IF @GoalComplete > 0
	BEGIN
		SELECT @GoalEarly = COUNT(*) FROM Goal
		Where MemberID = @MemberID AND Status = 3 AND Variance < 0
	
		SELECT @GoalOntime = COUNT(*) FROM Goal
		Where MemberID = @MemberID AND Status = 3 AND Variance = 0
	
		SELECT @GoalLate = COUNT(*) FROM Goal
		Where MemberID = @MemberID AND Status = 3 AND Variance > 0
	END
END

SET @Result = '<PTSTB ' + 
'companycoursevisit="'       + CAST(@CompanyCourseVisit AS VARCHAR(10)) + '" ' +
'companycourse30="'         + CAST(@CompanyCourse30 AS VARCHAR(10)) + '" ' +
'companycoursetotal="'      + CAST(@CompanyCourseTotal AS VARCHAR(10)) + '" ' +
'companycourseregister="'   + CAST(@CompanyCourseRegister AS VARCHAR(10)) + '" ' +
'companycourseunregister="' + CAST(@CompanyCourseUnregister AS VARCHAR(10)) + '" ' +
'publiccourseregister="'    + CAST(@PublicCourseRegister AS VARCHAR(10)) + '" ' +
'publiccoursevisit="'       + CAST(@PublicCoursevisit AS VARCHAR(10)) + '" ' +
'publiccourse30="'          + CAST(@PublicCourse30 AS VARCHAR(10)) + '" ' +
'companyassessmentvisit="'  + CAST(@CompanyAssessmentvisit AS VARCHAR(10)) + '" ' +
'companyassessment30="'     + CAST(@CompanyAssessment30 AS VARCHAR(10)) + '" ' +
'companyassessmenttotal="'  + CAST(@CompanyAssessmentTotal AS VARCHAR(10)) + '" ' +
'companyassessmenttaken="'  + CAST(@CompanyAssessmentTaken AS VARCHAR(10)) + '" ' +
'publicassessmentvisit="'   + CAST(@PublicAssessmentVisit AS VARCHAR(10)) + '" ' +
'publicassessment30="'      + CAST(@PublicAssessment30 AS VARCHAR(10)) + '" ' +
'publicassessmenttaken="'   + CAST(@PublicAssessmentTaken AS VARCHAR(10)) + '" ' +
'surveyvisit="'             + CAST(@SurveyVisit AS VARCHAR(10)) + '" ' +
'survey30="'                + CAST(@Survey30 AS VARCHAR(10)) + '" ' +
'surveytaken="'             + CAST(@SurveyTaken AS VARCHAR(10)) + '" ' +
'surveyuntaken="'           + CAST(@SurveyUntaken AS VARCHAR(10)) + '" ' +
'suggestionsubmitted="'     + CAST(@SuggestionSubmitted AS VARCHAR(10)) + '" ' +
'suggestionreplied="'       + CAST(@SuggestionReplied AS VARCHAR(10)) + '" ' +
'suggestionvisit="'         + CAST(@SuggestionVisit AS VARCHAR(10)) + '" ' +
'suggestion30="'            + CAST(@Suggestion30 AS VARCHAR(10)) + '" ' +
'messageposted="'           + CAST(@MessagePosted AS VARCHAR(10)) + '" ' +
'messagereplied="'          + CAST(@MessageReplied AS VARCHAR(10)) + '" ' +
'messagevisit="'            + CAST(@MessageVisit AS VARCHAR(10)) + '" ' +
'message30="'               + CAST(@Message30 AS VARCHAR(10)) + '" ' +
'favoritecompany="'         + CAST(@FavoriteCompany AS VARCHAR(10)) + '" ' +
'favoritepublic="'          + CAST(@FavoritePublic AS VARCHAR(10)) + '" ' +
'favoritechat="'            + CAST(@FavoriteChat AS VARCHAR(10)) + '" ' +
'favoriteforum="'           + CAST(@FavoriteForum AS VARCHAR(10)) + '" ' +
'favoriteccvisit="'         + CAST(@FavoriteCCVisit AS VARCHAR(10)) + '" ' +
'favoritecc30="'            + CAST(@FavoriteCC30 AS VARCHAR(10)) + '" ' +
'favoritepcvisit="'         + CAST(@FavoritePCVisit AS VARCHAR(10)) + '" ' +
'favoritepc30="'            + CAST(@FavoritePC30 AS VARCHAR(10)) + '" ' +
'favoritempvisit="'         + CAST(@FavoriteMPVisit AS VARCHAR(10)) + '" ' +
'favoritemp30="'            + CAST(@FavoriteMP30 AS VARCHAR(10)) + '" ' +
'favoritemrvisit="'         + CAST(@FavoriteMRVisit AS VARCHAR(10)) + '" ' +
'favoritemr30="'            + CAST(@FavoriteMR30 AS VARCHAR(10)) + '" ' +
'expectation="'             + CAST(@Expectation AS VARCHAR(10)) + '" ' +
'goaltotal="'               + CAST(@GoalTotal AS VARCHAR(10)) + '" ' +
'goaldeclare="'             + CAST(@GoalDeclare AS VARCHAR(10)) + '" ' +
'goalcommit="'              + CAST(@GoalCommit AS VARCHAR(10)) + '" ' +
'goalcomplete="'            + CAST(@GoalComplete AS VARCHAR(10)) + '" ' +
'goalearly="'               + CAST(@GoalEarly AS VARCHAR(10)) + '" ' +
'goalontime="'              + CAST(@GoalOntime AS VARCHAR(10)) + '" ' +
'goallate="'                + CAST(@GoalLate AS VARCHAR(10)) + '"/>'

GO