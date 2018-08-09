EXEC [dbo].pts_CheckProc 'pts_MemberNews_GetMember'
GO

CREATE PROCEDURE [dbo].pts_MemberNews_GetMember
   @MemberID int ,
   @NewsLetterID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT @Result = MemberNewsID FROM MemberNews WHERE NewsLetterID = @NewsLetterID AND MemberID = @MemberID

IF @Result IS NULL SET @Result = 0

GO
