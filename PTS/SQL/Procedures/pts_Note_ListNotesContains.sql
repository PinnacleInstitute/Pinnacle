EXEC [dbo].pts_CheckProc 'pts_Note_ListNotesContains'
GO

CREATE PROCEDURE [dbo].pts_Note_ListNotesContains
   @Notes nvarchar (1000) ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT      nt.NoteID, 
         nt.NoteDate, 
         nt.Notes, 
         nt.OwnerType, 
         nt.OwnerID, 
         nt.AuthUserID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
         nt.IsLocked, 
         nt.IsFrozen, 
         nt.IsReminder
FROM Note AS nt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
WHERE (nt.NoteDate >= @FromDate)
 AND (nt.NoteDate <= @ToDate)
 AND (nt.Notes LIKE '%'  + @Notes + '%')

ORDER BY   nt.NoteDate

GO