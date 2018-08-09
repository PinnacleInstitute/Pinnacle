EXEC [dbo].pts_CheckProc 'pts_Note_ListCustom_18'
GO
--User Containing Keyword Project Notes 
--List all project notes that belong to the specified user and contains the specified keyword. 
CREATE PROCEDURE [dbo].pts_Note_ListCustom_18
   @FromDate datetime ,
   @ToDate datetime ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @AuthUserID int, @CompanyID int, @MemberID int, @Secure int, @pos int, @Keyword nvarchar (80)
SET @AuthUserID = 0
SET @CompanyID = 0
SET @MemberID = 0
SET @Secure = -1
SET @Keyword = @Data3

IF @Data1 != '' 
BEGIN
	IF LEFT(@Data1,1) = 'C' 
		SET @CompanyID = CAST(SUBSTRING(@Data1,2,10) AS int)
	Else
		SET @AuthUserID = CAST(@Data1 AS int)
END

IF @Data2 != '' 
BEGIN
	SET @pos = CHARINDEX( '-', @Data2 )
	IF @pos > 0
	BEGIN
		SET @MemberID = CAST(LEFT(@Data2, @pos-1) AS int)
		SET @Secure = CAST(SUBSTRING(@Data2, @pos+1, 10) AS int)
	END
	ELSE
		SET @MemberID = CAST(@Data2 AS int)
END

-- If We have a User, view all his notes
IF @AuthUserID > 0
BEGIN
	SELECT   nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, nt.AuthUserID, 
				LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
				nt.IsLocked, nt.IsFrozen, nt.IsReminder, 
				pj.ProjectName AS 'Data1', '' AS 'Data2', pj.Status AS 'Data3'
	FROM Note AS nt (NOLOCK)
	JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	JOIN Project AS pj (NOLOCK) ON (nt.OwnerID = pj.ProjectID AND nt.OwnerType = 75)
	WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
	AND nt.AuthUserID = @AuthUserID
	AND nt.Notes LIKE '%' + @Keyword + '%'

	UNION ALL

	SELECT   nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, nt.AuthUserID, 
				LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
				nt.IsLocked, nt.IsFrozen, nt.IsReminder, 
				pj.ProjectName AS 'Data1', tk.TaskName AS 'Data2', tk.Status AS 'Data3'
	FROM Note AS nt (NOLOCK)
	JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
	JOIN Task AS tk (NOLOCK) ON (nt.OwnerID = tk.TaskID AND nt.OwnerType = 74)
	JOIN Project AS pj (NOLOCK) ON (pj.ProjectID = tk.ProjectID)
	WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
	AND nt.AuthUserID = @AuthUserID
	AND nt.Notes LIKE '%' + @Keyword + '%'

	ORDER BY nt.NoteDate 
END

-- If We DON'T have a User, view all notes for Member's projects
IF @AuthUserID = 0
BEGIN
-- 	If the User can view projects by security level, get all projects in his security level
	IF @Secure >= 0
	BEGIN
		SELECT   nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, nt.AuthUserID, 
					LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
					nt.IsLocked, nt.IsFrozen, nt.IsReminder, 
					pj.ProjectName AS 'Data1', '' AS 'Data2', pj.Status AS 'Data3'
		FROM Note AS nt (NOLOCK)
		JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
		JOIN Project AS pj (NOLOCK) ON (nt.OwnerID = pj.ProjectID AND nt.OwnerType = 75)
		WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
		AND nt.Notes LIKE '%' + @Keyword + '%'
		AND pj.CompanyID = @CompanyID
		AND pj.Secure <= @Secure
	
		UNION ALL
	
		SELECT   nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, nt.AuthUserID, 
					LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
					nt.IsLocked, nt.IsFrozen, nt.IsReminder, 
					pj.ProjectName AS 'Data1', tk.TaskName AS 'Data2', tk.Status AS 'Data3'
		FROM Note AS nt (NOLOCK)
		JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
		JOIN Task AS tk (NOLOCK) ON (nt.OwnerID = tk.TaskID AND nt.OwnerType = 74)
		JOIN Project AS pj (NOLOCK) ON (pj.ProjectID = tk.ProjectID)
		WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
		AND nt.Notes LIKE '%' + @Keyword + '%'
		AND pj.CompanyID = @CompanyID
		AND pj.Secure <= @Secure
	
		ORDER BY nt.NoteDate 
	END
-- 	If the User can NOT view projects by security level, get only projects he is assigned to
	IF @Secure < 0
	BEGIN
		SELECT   nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, nt.AuthUserID, 
					LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
					nt.IsLocked, nt.IsFrozen, nt.IsReminder, 
					pj.ProjectName AS 'Data1', '' AS 'Data2', pj.Status AS 'Data3'
		FROM Note AS nt (NOLOCK)
		JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
		JOIN Project AS pj (NOLOCK) ON (nt.OwnerID = pj.ProjectID AND nt.OwnerType = 75)
		LEFT OUTER JOIN ProjectMember AS pjm (NOLOCK) ON (pj.ProjectID = pjm.ProjectID and pjm.MemberID = @MemberID)
		WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
		AND (pj.MemberID = @MemberID OR pjm.MemberID = @MemberID)
		AND nt.Notes LIKE '%' + @Keyword + '%'
	
		UNION ALL
	
		SELECT   nt.NoteID, nt.NoteDate, nt.Notes, nt.OwnerType, nt.OwnerID, nt.AuthUserID, 
					LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
					nt.IsLocked, nt.IsFrozen, nt.IsReminder, 
					pj.ProjectName AS 'Data1', tk.TaskName AS 'Data2', tk.Status AS 'Data3'
		FROM Note AS nt (NOLOCK)
		JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
		JOIN Task AS tk (NOLOCK) ON (nt.OwnerID = tk.TaskID AND nt.OwnerType = 74)
		JOIN Project AS pj (NOLOCK) ON (pj.ProjectID = tk.ProjectID)
		LEFT OUTER JOIN ProjectMember AS pjm (NOLOCK) ON (pj.ProjectID = pjm.ProjectID and pjm.MemberID = @MemberID)
		WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
		AND (pj.MemberID = @MemberID OR pjm.MemberID = @MemberID)
		AND nt.Notes LIKE '%' + @Keyword + '%'
	
		ORDER BY nt.NoteDate 
	END
END

GO