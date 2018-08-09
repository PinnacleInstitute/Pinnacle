EXEC [dbo].pts_CheckProc 'pts_Appt_ListDayOptions'
GO

CREATE PROCEDURE [dbo].pts_Appt_ListDayOptions
   @CalendarID int ,
   @FromDate datetime ,
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
	DECLARE @wDay int, @dDay int, @yDay int
--	-- these variables are for calculating recurring appointments
	SET @wDay = DATEPART(dw, @FromDate)
	SET @dDay = DATEPART(dd, @FromDate)
	SET @yDay = DATEPART(dy, @FromDate)
	
	INSERT INTO @APPT
	SELECT ApptID, ApptName, Location, Note, StartDate, StartTime, EndDate, EndTime, 
	       IsAllDay, Status, ApptType, Importance, Show, Recur, RecurDate, IsEdit, IsPlan
	FROM   Appt (NOLOCK)
	WHERE  (CalendarID = @CalendarID) 
	AND ( ( StartDate <= @FromDate AND EndDate >= @FromDate )
	 	OR ( ( Recur != 0 AND StartDate < @FromDate AND (RecurDate = 0 OR RecurDate >= @FromDate) )
			AND ( ( Recur = 1 AND DATEPART(dw, StartDate) = @wDay )
		  	OR    ( Recur = 2 AND DATEPART(dd, StartDate) = @dDay )
		  	OR    ( Recur = 3 AND DATEPART(dy, StartDate) = @yDay ) )
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
	se.NameFirst + ' ' + se.NameLast 'Note', 
	se.CompleteDate 'StartDate', 
	'' 'StartTime', 
	se.CompleteDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', se.Status 'Status', -13 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Session AS se (NOLOCK)
	LEFT OUTER JOIN Course AS cs (NOLOCK) ON (se.CourseID = cs.CourseID)
	WHERE (se.MemberID = @MemberID) AND (dbo.wtfn_DateOnly(se.CompleteDate) = @FromDate)
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
	WHERE (ma.MemberID = @MemberID) AND (dbo.wtfn_DateOnly(ma.CompleteDate) = @FromDate)
END

--Get Goals
IF CHARINDEX('G', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(700000000) + GoalID 'ApptID', 
	GoalName 'ApptName', 
	'' 'Location', 
	Left([Description],500) 'Note', 
	CommitDate 'StartDate', 
	'' 'StartTime', 
	CommitDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', Status 'Status', -70 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Goal (NOLOCK)
	WHERE (MemberID = @MemberID) AND (dbo.wtfn_DateOnly(CommitDate) = @FromDate)
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
	WHERE (go.MemberID = @MemberID) AND (dbo.wtfn_DateOnly(CommitDate) = @FromDate)
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
	Left([Description],500) 'Note', 
	EstEndDate 'StartDate', 
	'' 'StartTime', 
	EstEndDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', Status 'Status', -75 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Project (NOLOCK)
	WHERE (MemberID = @MemberID) AND (dbo.wtfn_DateOnly(EstEndDate) = @FromDate)
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
	Left([Description],500) 'Note', 
	EstEndDate 'StartDate', 
	'' 'StartTime', 
	EstEndDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', Status 'Status', -74 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Task (NOLOCK)
	WHERE (MemberID = @MemberID) AND (dbo.wtfn_DateOnly(EstEndDate) = @FromDate)
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
	Left([Description],500) 'Note', 
	NextDate 'StartDate', 
	NextTime 'StartTime', 
	NextDate 'EndDate', 
	'' 'EndTime', 
	0 'IsAllDay', NextEvent 'Status', -81 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Prospect (NOLOCK)
	WHERE (MemberID = @MemberID) AND (dbo.wtfn_DateOnly(NextDate) = @FromDate)
END

--Get Sales Notes
IF CHARINDEX('N', @Options) > 0
BEGIN
	INSERT INTO @APPT
	SELECT 
	(900000000) + nt.NoteID 'ApptID', 
	pr.ProspectName 'ApptName', 
	'' 'Location', 
	Left(nt.Notes,500) 'Note', 
	nt.NoteDate 'StartDate', 
	'' 'StartTime', 
	nt.NoteDate 'EndDate', 
	'' 'EndTime', 
	1 'IsAllDay', nt.IsReminder 'Status', -90 'ApptType', 2 'Importance', 1 'Show', 0 'Recur', 0 'RecurDate', 0 'IsEdit', 0 'IsPlan'
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (nt.OwnerType = 81 AND nt.OwnerID = pr.ProspectID)
	WHERE (pr.MemberID = @MemberID) AND (dbo.wtfn_DateOnly(nt.NoteDate) = @FromDate)
	AND nt.AuthUserID <> 1
END

--Get Followup Events
IF CHARINDEX('E', @Options) > 0
BEGIN
	DECLARE @Today datetime
	SET @Today = GETDATE()
	
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
	   ( ev.Recur = 0 AND dbo.wtfn_DateOnly(ev.EventDate) = @FromDate )
	OR ( ev.Recur = 1 AND Day(ev.EventDate) = Day(@FromDate) AND Month(ev.EventDate) = Month(@FromDate) )
	OR ( ev.Recur = 2 AND Day(ev.EventDate) = Day(@FromDate) )
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
	WHERE (MemberID = @MemberID) AND (dbo.wtfn_DateOnly(CallBackDate) = @FromDate)
END

SELECT ApptID, ApptName, Location, Note, StartDate, StartTime, EndDate, EndTime, 
       IsAllDay, Status, ApptType, Importance, Show, Recur, RecurDate, IsEdit, IsPlan
FROM   @Appt 
ORDER BY StartDate

GO
