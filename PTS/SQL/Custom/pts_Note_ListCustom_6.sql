EXEC [dbo].pts_CheckProc 'pts_Note_ListCustom_6'
GO
--User Activity Prospect Notes 
--List all prospect notes that are not reminders that belong to the specified user. 
CREATE PROCEDURE [dbo].pts_Note_ListCustom_6
   @FromDate datetime ,
   @ToDate datetime ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @AuthUserID int
IF @Data1 != '' 
	SET @AuthUserID = CAST(@Data1 AS int)
Else
	SET @AuthUserID = 0

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
         pr.ProspectName AS 'Data1',
         pr.Status AS 'Data2',
         ss.SalesStepName AS 'Data3'
FROM Note AS nt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
JOIN Prospect AS pr (NOLOCK) ON (nt.OwnerID = pr.ProspectID AND nt.OwnerType = 81)
LEFT OUTER JOIN SalesStep AS ss (NOLOCK) ON (pr.Status = ss.SalesStepID)
WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
AND nt.AuthUserID = @AuthUserID
AND (nt.IsReminder = 0)

ORDER BY nt.NoteDate 

GO