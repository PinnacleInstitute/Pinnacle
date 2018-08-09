EXEC [dbo].pts_CheckProc 'pts_QuizChoice_Add'
 GO

CREATE PROCEDURE [dbo].pts_QuizChoice_Add ( 
   @QuizChoiceID int OUTPUT,
   @QuizQuestionID int,
   @QuizChoiceText nvarchar (1000),
   @Seq int,
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
   FROM QuizChoice (NOLOCK)
   WHERE QuizQuestionID = @QuizQuestionID
   SET @Seq = @Seq + 10
END

INSERT INTO QuizChoice (
            QuizQuestionID , 
            QuizChoiceText , 
            Seq
            )
VALUES (
            @QuizQuestionID ,
            @QuizChoiceText ,
            @Seq            )

SET @mNewID = @@IDENTITY

SET @QuizChoiceID = @mNewID

GO