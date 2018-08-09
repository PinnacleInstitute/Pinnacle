EXEC [dbo].pts_CheckProc 'pts_Appt_ListCalendarOptions'
GO

CREATE PROCEDURE [dbo].pts_Appt_ListCalendarOptions
   @CalendarID int ,
   @FromDate datetime ,
   @ToDate datetime ,
   @ApptName nvarchar (60)
AS

SET NOCOUNT ON

DECLARE @Options nvarchar(60), @MemberID int
SET @Options = @ApptName
SELECT @MemberID = MemberID FROM Calendar WHERE CalendarID = @CalendarID

DECLARE @Appt TABLE(
   ApptID int ,
   ApptName nvarchar (60),
   Location nvarchar (80),
   Note nvarchar (500),
   StartDate datetime,
   StartTime varchar (8),
   EndDate datetime,
   EndTime varchar (8),
   IsAllDay bit,
   Status int,
   ApptType int,
   Importance int,
   Show int,
   Recur int,
   RecurDate datetime,
   IsEdit bit,
   IsPlan bit
)

--Get Appointments
IF CHARINDEX('1', @Options) > 0
BEGIN
	DECLARE @wDay1 int, @wDay2 int, @dDay1 int, @dDay2 int, @yDay1 int, @yDay2 int
--	-- these variables are for calculating recurring appointments
--	-- They assume the @FromDate and @Todate are a single day or month
	SET @wDay1 = DATEPART(dw, @FromDate)
	SET @wDay2 = DATEPART(dw, @ToDate)
	SET @dDay1 = DATEPART(dd, @FromDate)
	SET @dDay2 = DATEPART(dd, @ToDate)
	SET @yDay1 = DATEPART(dy, @FromDate)
	SET @yDay2 = DATEPART(dy, @ToDate)
--	-- Set monthly range of days of week
	IF @FromDate != @ToDate 
	BEGIN
		SET @wDay1 = 1
		SET @wDay2 = 7
	END
	
	INSERT INTO @APPT
	SELECT ApptID, ApptName, Location, Note, StartDate, StartTime, EndDate, EndTime, 
	       IsAllDay, Status, ApptType, Importance, Show, Recur, RecurDate, IsEdit, IsPlan
	FROM   Appt (NOLOCK)
	WHERE  (CalendarID = @CalendarID) 
	AND ( ( StartDate >= @FromDate AND StartDate <= @ToDate )
		OR ( EndDate >= @FromDate AND EndDate <= @ToDate )
	 	OR ( ( Recur != 0 AND StartDate < @FromDate AND (RecurDate = 0 OR RecurDate >= @FromDate) )
			AND ( ( Recur = 1 AND DATEPART(dw, StartDate) BETWEEN @wDay1 AND @wDay2 )
		  	OR    ( Recur = 2 AND DATEPART(dd, StartDate) BETWEEN @dDay1 AND @dDay2 )
		  	OR    ( Recur = 3 AND DATEPART(dy, StartDate) BETWEEN @yDay1 AND @yDay2 ) )
		   ) 
	    ) 
END

--Get Classes
IF CHARINDEX('C', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(130000000) + se.SessionID 'ApptID', 
	cs.CourseName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	se.CompleteDate 'StartDate', 
	'' 'StartTime', 
	se.CompleteDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', se.Status 'Status', -13 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Session AS se (NOLOCK)
	LEFT OUTER JOIN Course AS cs (NOLOCK) ON (se.CourseID = cs.CourseID)
	WHERE (se.MemberID = @MemberID) AND (se.CompleteDate >= @FromDate) AND (dbo.wtfn_DateOnly(se.CompleteDate) <= @ToDate)
	AND se.Status >= 5 AND IsInactive = 0
END

--Get Assessments
IF CHARINDEX('A', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(310000000) + ma.MemberAssessID 'ApptID', 
	am.AssessmentName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	ma.CompleteDate 'StartDate', 
	'' 'StartTime', 
	ma.CompleteDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', ma.Status 'Status', -31 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM MemberAssess AS ma (NOLOCK)
	LEFT OUTER JOIN Assessment AS am (NOLOCK) ON (ma.AssessmentID = am.AssessmentID)
	WHERE (ma.MemberID = @MemberID) AND (ma.CompleteDate >= @FromDate) AND (dbo.wtfn_DateOnly(ma.CompleteDate) <= @ToDate)
END

--Get Goals
IF CHARINDEX('G', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(700000000) + GoalID 'ApptID', 
	GoalName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	CommitDate 'StartDate', 
	'' 'StartTime', 
	CommitDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', Status 'Status', -70 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Goal (NOLOCK)
	WHERE (MemberID = @MemberID) AND (CommitDate >= @FromDate) AND (dbo.wtfn_DateOnly(CommitDate) <= @ToDate)
	AND ProspectID = 0 AND Status <> 4
	AND Template = 0
END

--Get Service Goals
IF CHARINDEX('V', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(700000000) + go.GoalID 'ApptID', 
	go.GoalName 'ApptName', 
	pr.ProspectName 'Location', 
	'' 'Note', 
	go.CommitDate 'StartDate', 
	'' 'StartTime', 
	go.CommitDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', go.Status 'Status', -701 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Goal AS go (NOLOCK)
	LEFT OUTER JOIN Prospect AS pr ON go.ProspectID = pr.ProspectID
	WHERE (go.MemberID = @MemberID) AND (go.CommitDate >= @FromDate) AND (dbo.wtfn_DateOnly(go.CommitDate) <= @ToDate)
	AND go.ProspectID != 0 AND go.Status <> 4
END

--Get Projects
IF CHARINDEX('P', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(750000000) + ProjectID 'ApptID', 
	ProjectName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	EstEndDate 'StartDate', 
	'' 'StartTime', 
	EstEndDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', Status 'Status', -75 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Project (NOLOCK)
	WHERE (MemberID = @MemberID) AND (EstEndDate >= @FromDate) AND (dbo.wtfn_DateOnly(EstEndDate) <= @ToDate)
	AND Status <> 3
END

--Get Tasks
IF CHARINDEX('T', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(740000000) + TaskID 'ApptID', 
	TaskName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	EstEndDate 'StartDate', 
	'' 'StartTime', 
	EstEndDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', Status 'Status', -74 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Task (NOLOCK)
	WHERE (MemberID = @MemberID) AND (EstEndDate >= @FromDate) AND (dbo.wtfn_DateOnly(EstEndDate) <= @ToDate)
	AND Status <> 3
END

--Get Sales
IF CHARINDEX('S', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(810000000) + ProspectID 'ApptID', 
	ProspectName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	NextDate 'StartDate', 
	NextTime 'StartTime', 
	NextDate 'EndDate', 
	'' 'EndTime', 
	0 'IsAllDay', NextEvent 'Status', -81 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Prospect (NOLOCK)
	WHERE (MemberID = @MemberID) AND (NextDate >= @FromDate) AND (dbo.wtfn_DateOnly(NextDate) <= @ToDate)
END

--Get Sales Notes
IF CHARINDEX('N', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(900000000) + nt.NoteID 'ApptID', 
	pr.ProspectName 'ApptName', 
	'' 'Location', 
	'' 'Note', 
	nt.NoteDate 'StartDate', 
	'' 'StartTime', 
	nt.NoteDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', nt.IsReminder 'Status', -90 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (nt.OwnerType = 81 AND nt.OwnerID = pr.ProspectID)
	WHERE (pr.MemberID = @MemberID) AND (nt.NoteDate >= @FromDate) AND (dbo.wtfn_DateOnly(nt.NoteDate) <= @ToDate)
	AND nt.AuthUserID <> 1
END

--Get Followup Events
IF CHARINDEX('E', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(960000000) + ev.EventID 'ApptID', 
	pr.ProspectName 'ApptName', 
	'' 'Location', 
	ev.EventName 'Note', 
	ev.EventDate 'StartDate', 
	'' 'StartTime', 
	ev.EventDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', ev.EventType 'Status', -96 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Event AS ev (NOLOCK)
	LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (ev.OwnerType = 81 AND ev.OwnerID = pr.ProspectID)
	WHERE (pr.MemberID = @MemberID) 
	AND
	( 
	   ( ev.Recur = 0 AND ev.EventDate >= @FromDate) AND (dbo.wtfn_DateOnly(ev.EventDate) <= @ToDate)
	OR ( ev.Recur = 1 AND Day(ev.EventDate) >= Day(@FromDate) AND Month(ev.EventDate) >= Month(@FromDate) 			          AND Day(ev.EventDate) <= Day(@ToDate) AND Month(ev.EventDate) <= Month(@ToDate) )
	OR ( ev.Recur = 2 AND Day(ev.EventDate) >= Day(@FromDate) AND Day(ev.EventDate) <= Day(@ToDate) )
	)
END

--Get Lead CallBack Date and Time
IF CHARINDEX('L', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(220000000) + LeadID 'ApptID', 
	NameLast + ', ' + NameFirst 'ApptName', 
	'' 'Location', 
	Left(Comment,500) 'Note', 
	CallBackDate 'StartDate', 
	CallBackTime 'StartTime', 
	CallBackDate 'EndDate', 
	'' 'EndTime', 
	0 'IsAllDay', Status 'Status', -22 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Lead (NOLOCK)
	WHERE (MemberID = @MemberID) AND (CallBackDate >= @FromDate) AND (dbo.wtfn_DateOnly(CallBackDate) <= @ToDate)
END

SELECT ApptID, ApptName, Location, Note, StartDate, StartTime, EndDate, EndTime, 
       IsAllDay, Status, ApptType, Importance, Show, Recur, RecurDate, IsEdit, IsPlan
FROM   @Appt 
ORDER BY StartDate

GO

