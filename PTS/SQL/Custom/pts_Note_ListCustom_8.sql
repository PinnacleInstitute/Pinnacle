EXEC [dbo].pts_CheckProc 'pts_Note_ListCustom_8'
GO
--User Containing Keyword Prospect Notes 
--List all prospect notes that belong to the specified user and contain the specified keyword. 
CREATE PROCEDURE [dbo].pts_Note_ListCustom_8
   @FromDate datetime ,
   @ToDate datetime ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @AuthUserID int, @Keyword nvarchar (80)
IF @Data1 != '' 
	SET @AuthUserID = CAST(@Data1 AS int)
Else
	SET @AuthUserID = 0

SET @Keyword = @Data2

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
JOIN SalesStep AS ss (NOLOCK) ON (pr.Status = ss.SalesStepID)
WHERE nt.NoteDate >= @FromDate AND nt.NoteDate <= @ToDate
AND nt.AuthUserID = @AuthUserID
AND nt.Notes LIKE '%' + @Keyword + '%'

ORDER BY nt.NoteDate 

GO