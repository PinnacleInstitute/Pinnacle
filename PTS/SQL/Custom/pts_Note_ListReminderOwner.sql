EXEC [dbo].pts_CheckProc 'pts_Note_ListReminderOwner'
GO

--EXEC pts_Note_ListReminderOwner 81, 0, '4/30/05', '4/30/05'

CREATE PROCEDURE [dbo].pts_Note_ListReminderOwner
   @OwnerType int ,
   @AuthUserID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

-- Company -------
IF @OwnerType = 38
BEGIN
	SELECT nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, co.CompanyName AS 'Owner', 
	nt.AuthUserID, au.NameFirst + ' ' + au.NameLast AS 'UserName', nt.IsLocked, nt.IsFrozen, nt.IsReminder
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN Company AS co (NOLOCK) ON (nt.OwnerID = co.CompanyID)
	WHERE (nt.OwnerType = @OwnerType) AND (@AuthUserID = 0 OR nt.AuthUserID = @AuthUserID)
	AND nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate AND nt.IsReminder = 1
	ORDER BY nt.NoteDate 
END
-- Member -------
IF @OwnerType = 4
BEGIN
	SELECT nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, me.CompanyName AS 'Owner', 
	nt.AuthUserID, au.NameFirst + ' ' + au.NameLast AS 'UserName', nt.IsLocked, nt.IsFrozen, nt.IsReminder
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN Member AS me (NOLOCK) ON (nt.OwnerID = me.MemberID)
	WHERE (nt.OwnerType = @OwnerType) AND (@AuthUserID = 0 OR nt.AuthUserID = @AuthUserID)
	AND nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate AND nt.IsReminder = 1
	ORDER BY nt.NoteDate 
END
-- Trainer -------
IF @OwnerType = 3
BEGIN
	SELECT nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, tr.CompanyName AS 'Owner', 
	nt.AuthUserID, au.NameFirst + ' ' + au.NameLast AS 'UserName', nt.IsLocked, nt.IsFrozen, nt.IsReminder
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (nt.OwnerID = tr.TrainerID)
	WHERE (nt.OwnerType = @OwnerType) AND (@AuthUserID = 0 OR nt.AuthUserID = @AuthUserID)
	AND nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate AND nt.IsReminder = 1
	ORDER BY nt.NoteDate 
END
-- Affiliate -------
IF @OwnerType = 6
BEGIN
	SELECT nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, af.AffiliateName AS 'Owner', 
	nt.AuthUserID, au.NameFirst + ' ' + au.NameLast AS 'UserName', nt.IsLocked, nt.IsFrozen, nt.IsReminder
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN Affiliate AS af (NOLOCK) ON (nt.OwnerID = af.AffiliateID)
	WHERE (nt.OwnerType = @OwnerType) AND (@AuthUserID = 0 OR nt.AuthUserID = @AuthUserID)
	AND nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate AND nt.IsReminder = 1
	ORDER BY nt.NoteDate 
END
-- Prospect -------
IF @OwnerType = 81
BEGIN
	SELECT nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, pr.ProspectName AS 'Owner',
	nt.AuthUserID, au.NameFirst + ' ' + au.NameLast AS 'UserName', nt.IsLocked, nt.IsFrozen, nt.IsReminder
	FROM Note AS nt (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (nt.OwnerID = pr.ProspectID)
	WHERE (nt.OwnerType = @OwnerType) AND (@AuthUserID = 0 OR nt.AuthUserID = @AuthUserID)
	AND nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate AND nt.IsReminder = 1
	ORDER BY nt.NoteDate 
END

GO

