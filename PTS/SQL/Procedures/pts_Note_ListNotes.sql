EXEC [dbo].pts_CheckProc 'pts_Note_ListNotes'
GO

CREATE PROCEDURE [dbo].pts_Note_ListNotes
   @OwnerType int ,
   @OwnerID int
AS

SET NOCOUNT ON

SELECT      nt.NoteID, 
         nt.AuthUserID, 
         nt.NoteDate, 
         nt.Notes, 
         nt.IsLocked, 
         nt.IsFrozen, 
         nt.IsReminder, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName'
FROM Note AS nt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
WHERE (nt.OwnerType = @OwnerType)
 AND (nt.OwnerID = @OwnerID)

ORDER BY   nt.IsFrozen DESC , nt.NoteDate DESC , nt.NoteID DESC

GO