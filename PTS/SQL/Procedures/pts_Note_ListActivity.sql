EXEC [dbo].pts_CheckProc 'pts_Note_ListActivity'
GO

CREATE PROCEDURE [dbo].pts_Note_ListActivity
   @OwnerType int ,
   @AuthUserID int ,
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
WHERE ((@AuthUserID = 0)
 OR (nt.AuthUserID = @AuthUserID))
 AND (nt.NoteDate >= @FromDate)
 AND (nt.NoteDate <= @ToDate)
 AND ((@OwnerType = 0)
 OR (nt.OwnerType = @OwnerType))
 AND (nt.IsReminder = 0)

ORDER BY   nt.NoteDate

GO