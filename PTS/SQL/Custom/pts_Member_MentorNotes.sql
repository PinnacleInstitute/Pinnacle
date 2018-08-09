EXEC [dbo].pts_CheckProc 'pts_Member_MentorNotes'
GO

CREATE PROCEDURE [dbo].pts_Member_MentorNotes
   @MemberID int ,
   @VisitDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SELECT @Count = COUNT(nt.noteid)
FROM Note AS nt
JOIN Member AS me ON nt.OwnerType = -4 AND nt.OwnerID = me.MemberID
WHERE nt.NoteDate > @VisitDate AND (me.MemberID = @MemberID OR  me.MentorID = @MemberID)

GO

