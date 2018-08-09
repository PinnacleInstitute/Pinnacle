EXEC [dbo].pts_CheckProc 'pts_MemberNews_DeleteMember'
GO

CREATE PROCEDURE [dbo].pts_MemberNews_DeleteMember
   @MemberID int ,
   @NewsLetterID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DELETE MemberNews WHERE NewsLetterID = @NewsLetterID AND MemberID = @MemberID

GO