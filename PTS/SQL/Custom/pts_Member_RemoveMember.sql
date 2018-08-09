EXEC [dbo].pts_CheckProc 'pts_Member_RemoveMember'
GO

CREATE PROCEDURE [dbo].pts_Member_RemoveMember
   @MemberID int ,
   @Status int
AS

SET NOCOUNT ON

IF @Status = 1 
BEGIN
	UPDATE Member SET MentorID = 0 WHERE MemberID = @MemberID
END
IF @Status = 2 
BEGIN
	UPDATE Member SET GroupID = 0 WHERE MemberID = @MemberID
END

GO