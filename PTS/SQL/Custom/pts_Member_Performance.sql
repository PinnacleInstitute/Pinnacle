EXEC [dbo].pts_CheckProc 'pts_Member_Performance'
 GO

--TEST-----------------------------------------------
--DECLARE @Result varchar(1000)
--EXEC pts_Member_Performance 84, '1/1/01', '1/1/10', 'GgHhE6KL', @Result OUTPUT
--PRINT @Result

CREATE PROCEDURE [dbo].pts_Member_Performance ( 
	@MemberID int ,
	@ReportFromDate datetime ,
	@ReportToDate datetime ,
   	@CompanyName nvarchar (60) ,
	@Result varchar(1000) OUTPUT
    )
AS

DECLARE	@30Date datetime, @Options nvarchar (60), @AuthUserID int
SET @Options = @CompanyName
-- add one day to the ToDate for dates with times (like notes)
SET @ReportToDate = DATEADD( "d", 1, @ReportToDate )

SELECT @AuthUserID = AuthUserID FROM Member WHERE MemberID = @MemberID

DECLARE 
	@MentorNotes int,
	@Goals int,
	@Contacts int,
	@Prospects int,
	@ProspectsActive int,
	@ProspectNotes int,
	@Customers int,
	@CustomerNotes int,
	@Courses int,
	@Assessments int,
	@Certifications int

SET @MentorNotes = 0
SET @Goals = 0
SET @Contacts = 0
SET @Prospects = 0
SET @ProspectsActive = 0
SET @ProspectNotes = 0
SET @Customers = 0
SET @CustomerNotes = 0
SET @Courses = 0
SET @Assessments = 0
SET @Certifications = 0

-- Get Mentoring Notes posted by the current user
IF CHARINDEX('G', @Options) > 0 OR CHARINDEX('g', @Options) > 0
BEGIN
	SELECT @MentorNotes = COUNT(NoteID) 	FROM Note
	WHERE  OwnerType = -4
	AND    AuthUserID = @AuthUserID
	AND    NoteDate >= @ReportFromDate 
	AND    NoteDate < @ReportToDate 
END

-- Get Completed Goals
IF CHARINDEX('H', @Options) > 0
BEGIN
	SELECT @Goals = COUNT(GoalID) FROM Goal
	WHERE  MemberID = @MemberID
	AND    Status = 3
	AND    CompleteDate >= @ReportFromDate 
	AND    CompleteDate < @ReportToDate  
END

-- Get New Contacts
IF CHARINDEX('h', @Options) > 0
BEGIN
	SELECT @Contacts = COUNT(LeadID) FROM Lead 
	WHERE  MemberID = @MemberID 
	AND    LeadDate >= @ReportFromDate 
	AND    LeadDate < @ReportToDate 
END

-- Get New Prospects
IF CHARINDEX('E', @Options) > 0
BEGIN
	SELECT @Prospects = COUNT(ProspectID) FROM Prospect 
	WHERE  MemberID = @MemberID
	AND    CreateDate >= @ReportFromDate 
	AND    CreateDate < @ReportToDate 

	SELECT @ProspectsActive = COUNT(ProspectID) FROM Prospect 
	WHERE  MemberID = @MemberID
	AND    Status > 5 AND NextEvent <> 0 AND NextDate <> 0
	AND    CreateDate >= @ReportFromDate 
	AND    CreateDate < @ReportToDate 
	
	SELECT @ProspectNotes = COUNT(NoteID) FROM Note
	WHERE  OwnerType = 81
	AND    AuthUserID = @AuthUserID
	AND    NoteDate >= @ReportFromDate 
	AND    NoteDate < @ReportToDate 
END

-- Get Customers
IF CHARINDEX('6', @Options) > 0
BEGIN
	SELECT @Customers = COUNT(ProspectID) FROM Prospect 
	WHERE  MemberID = @MemberID 
	AND    Status = 4
	AND    CloseDate >= @ReportFromDate 
	AND    CloseDate < @ReportToDate 
	
	SELECT @CustomerNotes = COUNT(NoteID) FROM Note
	WHERE  OwnerType = -81
	AND    AuthUserID = @AuthUserID
	AND    NoteDate >= @ReportFromDate 
	AND    NoteDate < @ReportToDate 
END

-- Get Courses
IF CHARINDEX('K', @Options) > 0
BEGIN
	SELECT @Courses = COUNT(SessionID) FROM Session
	WHERE  MemberID = @MemberID
	AND    Status >= 5
	AND    CompleteDate >= @ReportFromDate 
	AND    CompleteDate < @ReportToDate 
END

-- Get Assessments and Certifications
IF CHARINDEX('L', @Options) > 0
BEGIN
	SELECT @Assessments = COUNT(ma.MemberAssessID) 
	FROM   MemberAssess AS ma
	JOIN   Assessment AS asm ON ma.AssessmentID = asm.AssessmentID
	WHERE  ma.MemberID = @MemberID
	AND    ma.CompleteDate >= @ReportFromDate 
	AND    ma.CompleteDate < @ReportToDate 
	AND    asm.IsCertify = 0
	
	SELECT @Certifications = COUNT(ma.MemberAssessID)
	FROM   MemberAssess AS ma
	JOIN   Assessment AS asm ON ma.AssessmentID = asm.AssessmentID
	WHERE  ma.MemberID = @MemberID
	AND    ma.CompleteDate >= @ReportFromDate 
	AND    ma.CompleteDate < @ReportToDate 
	AND    asm.IsCertify = 1
END


SET @Result = '<PTSPERFORMANCE ' + 
'mentornotes="'     + CAST(@MentorNotes AS VARCHAR(10)) + '" ' +
'goals="'           + CAST(@Goals AS VARCHAR(10)) + '" ' +
'contacts="'        + CAST(@Contacts AS VARCHAR(10)) + '" ' +
'prospects="'       + CAST(@Prospects AS VARCHAR(10)) + '" ' +
'prospectsactive="' + CAST(@ProspectsActive AS VARCHAR(10)) + '" ' +
'prospectnotes="'   + CAST(@ProspectNotes AS VARCHAR(10)) + '" ' +
'customers="'       + CAST(@Customers AS VARCHAR(10)) + '" ' +
'customernotes="'   + CAST(@CustomerNotes AS VARCHAR(10)) + '" ' +
'courses="'         + CAST(@Courses AS VARCHAR(10)) + '" ' +
'assessments="'     + CAST(@Assessments AS VARCHAR(10)) + '" ' +
'certifications="'  + CAST(@Certifications AS VARCHAR(10)) + '"/>'

GO
