EXEC [dbo].pts_CheckProc 'pts_Note_ListCustom_12'
GO
--Company Activity Prospect Notes 
--List all project notes that are not reminders that belong to the specified company. 
CREATE PROCEDURE [dbo].pts_Note_ListCustom_12
   @FromDate datetime ,
   @ToDate datetime ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CompanyID int
IF @Data1 != '' 
	SET @CompanyID = CAST(@Data1 AS int)
Else
	SET @CompanyID = 0

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
AND pj.CompanyID = @CompanyID
AND nt.AuthUserID <> 1
AND nt.IsReminder = 0

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
LEFT OUTER JOIN Project AS pj (NOLOCK) ON (pj.ProjectID = tk.ProjectID)
WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
AND pj.CompanyID = @CompanyID
AND nt.AuthUserID <> 1
AND nt.IsReminder = 0

ORDER BY nt.NoteDate 

GO