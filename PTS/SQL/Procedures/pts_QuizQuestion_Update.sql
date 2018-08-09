EXEC [dbo].pts_CheckProc 'pts_QuizQuestion_Update'
 GO

CREATE PROCEDURE [dbo].pts_QuizQuestion_Update ( 
   @QuizQuestionID int,
   @LessonID int,
   @QuizChoiceID int,
   @Question nvarchar (2000),
   @Explain nvarchar (1000),
   @Points int,
   @IsRandom bit,
   @Seq int,
   @MediaType int,
   @MediaFile varchar (80),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE qq
SET qq.LessonID = @LessonID ,
   qq.QuizChoiceID = @QuizChoiceID ,
   qq.Question = @Question ,
   qq.Explain = @Explain ,
   qq.Points = @Points ,
   qq.IsRandom = @IsRandom ,
   qq.Seq = @Seq ,
   qq.MediaType = @MediaType ,
   qq.MediaFile = @MediaFile
FROM QuizQuestion AS qq
WHERE qq.QuizQuestionID = @QuizQuestionID

GO