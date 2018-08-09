EXEC [dbo].pts_CheckProc 'pts_NewsLetter_CalcSubscribers'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_CalcSubscribers
   @NewsLetterID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Cnt int

SELECT @Cnt = COUNT(*) FROM MemberNews WHERE NewsLetterID = @NewsLetterID
UPDATE NewsLetter SET MemberCnt = @Cnt WHERE NewsLetterID = @NewsLetterID

SELECT @Cnt = COUNT(*) FROM Prospect WHERE NewsLetterID = @NewsLetterID AND Status = 2
UPDATE NewsLetter SET ProspectCnt = @Cnt WHERE NewsLetterID = @NewsLetterID

GO