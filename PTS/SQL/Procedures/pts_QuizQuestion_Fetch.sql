EXEC [dbo].pts_CheckProc 'pts_QuizQuestion_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_QuizQuestion_Fetch ( 
   @QuizQuestionID int,
   @LessonID int OUTPUT,
   @QuizChoiceID int OUTPUT,
   @Question nvarchar (2000) OUTPUT,
   @Explain nvarchar (1000) OUTPUT,
   @Points int OUTPUT,
   @IsRandom bit OUTPUT,
   @Seq int OUTPUT,
   @MediaType int OUTPUT,
   @MediaFile varchar (80) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @LessonID = qq.LessonID ,
   @QuizChoiceID = qq.QuizChoiceID ,
   @Question = qq.Question ,
   @Explain = qq.Explain ,
   @Points = qq.Points ,
   @IsRandom = qq.IsRandom ,
   @Seq = qq.Seq ,
   @MediaType = qq.MediaType ,
   @MediaFile = qq.MediaFile
FROM QuizQuestion AS qq (NOLOCK)
LEFT OUTER JOIN QuizChoice AS qc (NOLOCK) ON (qq.QuizQuestionID = qc.QuizQuestionID)
WHERE qq.QuizQuestionID = @QuizQuestionID

GO