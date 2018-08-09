EXEC [dbo].pts_CheckProc 'pts_QuizQuestion_Add'
 GO

CREATE PROCEDURE [dbo].pts_QuizQuestion_Add ( 
   @QuizQuestionID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM QuizQuestion (NOLOCK)
   WHERE LessonID = @LessonID
   SET @Seq = @Seq + 10
END

INSERT INTO QuizQuestion (
            LessonID , 
            QuizChoiceID , 
            Question , 
            Explain , 
            Points , 
            IsRandom , 
            Seq , 
            MediaType , 
            MediaFile
            )
VALUES (
            @LessonID ,
            @QuizChoiceID ,
            @Question ,
            @Explain ,
            @Points ,
            @IsRandom ,
            @Seq ,
            @MediaType ,
            @MediaFile            )

SET @mNewID = @@IDENTITY

SET @QuizQuestionID = @mNewID

GO