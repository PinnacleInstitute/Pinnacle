EXEC [dbo].pts_CheckProc 'pts_Note_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Note_Delete ( 
   @NoteID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE nt
FROM Note AS nt
WHERE nt.NoteID = @NoteID

GO