EXEC [dbo].pts_CheckProc 'pts_QuizAnswer_Add'
 GO

CREATE PROCEDURE [dbo].pts_QuizAnswer_Add ( 
   @QuizAnswerID int OUTPUT,
   @SessionLessonID int,
   @QuizQuestionID int,
   @QuizChoiceID int,
   @IsCorrect bit,
   @CreateDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO QuizAnswer (
            SessionLessonID , 
            QuizQuestionID , 
            QuizChoiceID , 
            IsCorrect , 
            CreateDate
            )
VALUES (
            @SessionLessonID ,
            @QuizQuestionID ,
            @QuizChoiceID ,
            @IsCorrect ,
            @CreateDate            )

SET @mNewID = @@IDENTITY

SET @QuizAnswerID = @mNewID

GO