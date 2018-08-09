EXEC [dbo].pts_CheckProc 'pts_NewsLetter_UpdateProspectCnt'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_UpdateProspectCnt
   @NewsLetterID int ,
   @ProspectCnt int ,
   @Result int OUTPUT

AS

SET NOCOUNT ON

IF @ProspectCnt != 0
	UPDATE NewsLetter SET ProspectCnt = ProspectCnt + @ProspectCnt WHERE NewsLetterID = @NewsLetterID

GO