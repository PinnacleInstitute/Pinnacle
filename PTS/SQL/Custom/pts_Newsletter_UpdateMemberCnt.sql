EXEC [dbo].pts_CheckProc 'pts_NewsLetter_UpdateMemberCnt'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_UpdateMemberCnt
   @NewsLetterID int ,
   @MemberCnt int ,
   @Result int OUTPUT

AS

SET NOCOUNT ON

IF @MemberCnt != 0
	UPDATE NewsLetter SET MemberCnt = MemberCnt + @MemberCnt WHERE NewsLetterID = @NewsLetterID

GO