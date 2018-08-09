EXEC [dbo].pts_CheckProc 'pts_SurveyChoice_Add'
 GO

CREATE PROCEDURE [dbo].pts_SurveyChoice_Add ( 
   @SurveyChoiceID int OUTPUT,
   @SurveyQuestionID int,
   @Choice nvarchar (500),
   @Seq int,
   @Total int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM SurveyChoice (NOLOCK)
   WHERE SurveyQuestionID = @SurveyQuestionID
   SET @Seq = @Seq + 10
END

INSERT INTO SurveyChoice (
            SurveyQuestionID , 
            Choice , 
            Seq , 
            Total
            )
VALUES (
            @SurveyQuestionID ,
            @Choice ,
            @Seq ,
            @Total            )

SET @mNewID = @@IDENTITY

SET @SurveyChoiceID = @mNewID

GO