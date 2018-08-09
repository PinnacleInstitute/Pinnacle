EXEC [dbo].pts_CheckProc 'pts_Note_ListCustom_27'
GO
--Project User Starting Keyword Project Notes 
--List all project notes that belong to the specified project user and start with the specified keyword. 
CREATE PROCEDURE [dbo].pts_Note_ListCustom_27
   @FromDate datetime ,
   @ToDate datetime ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @ProjectID int, @AuthUserID int, @Keyword nvarchar (80)
IF @Data1 != '' 
	SET @ProjectID = CAST(@Data1 AS int)
Else
	SET @ProjectID = 0
	
IF @Data1 != '' 
	SET @AuthUserID = CAST(@Data2 AS int)
Else
	SET @AuthUserID = 0

SET @Keyword = @Data3

SELECT   nt.NoteID, 
         nt.NoteDate, 
         nt.Notes, 
         nt.OwnerType, 
         nt.OwnerID, 
         nt.AuthUserID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
         nt.IsLocked, 
         nt.IsFrozen, 
         nt.IsReminder,
         pj.ProjectName AS 'Data1',
         '' AS 'Data2',
         pj.Status AS 'Data3'
FROM Note AS nt (NOLOCK)
JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
JOIN Project AS pj (NOLOCK) ON (nt.OwnerID = pj.ProjectID AND nt.OwnerType = 75)
WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
AND pj.ProjectID = @ProjectID
AND nt.AuthUserID = @AuthUserID
AND nt.Notes LIKE @Keyword + '%'

UNION ALL

SELECT   nt.NoteID, 
         nt.NoteDate, 
         nt.Notes, 
         nt.OwnerType, 
         nt.OwnerID, 
         nt.AuthUserID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
         nt.IsLocked, 
         nt.IsFrozen, 
         nt.IsReminder,
         pj.ProjectName AS 'Data1',
         tk.TaskName AS 'Data2',
         tk.Status AS 'Data3'
FROM Note AS nt (NOLOCK)
JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
JOIN Task AS tk (NOLOCK) ON (nt.OwnerID = tk.TaskID AND nt.OwnerType = 74)
JOIN Project AS pj (NOLOCK) ON (pj.ProjectID = tk.ProjectID)
WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
AND pj.ProjectID = @ProjectID
AND nt.AuthUserID = @AuthUserID
AND nt.Notes LIKE @Keyword + '%'

ORDER BY nt.NoteDate 

GO