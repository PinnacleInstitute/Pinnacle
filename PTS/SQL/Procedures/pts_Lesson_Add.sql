EXEC [dbo].pts_CheckProc 'pts_Lesson_Add'
 GO

CREATE PROCEDURE [dbo].pts_Lesson_Add ( 
   @LessonID int OUTPUT,
   @CourseID int,
   @LessonName nvarchar (80),
   @Description nvarchar (1000),
   @Status int,
   @LessonLength int,
   @Seq int,
   @MediaURL varchar (250),
   @MediaType int,
   @MediaLength int,
   @MediaWidth int,
   @MediaHeight int,
   @Content int,
   @Quiz int,
   @QuizLimit int,
   @QuizLength int,
   @PassingGrade int,
   @QuizWeight int,
   @IsPassQuiz bit,
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
   FROM Lesson (NOLOCK)
   WHERE CourseID = @CourseID
   SET @Seq = @Seq + 10
END

INSERT INTO Lesson (
            CourseID , 
            LessonName , 
            Description , 
            Status , 
            LessonLength , 
            Seq , 
            MediaURL , 
            MediaType , 
            MediaLength , 
            MediaWidth , 
            MediaHeight , 
            Content , 
            Quiz , 
            QuizLimit , 
            QuizLength , 
            PassingGrade , 
            QuizWeight , 
            IsPassQuiz
            )
VALUES (
            @CourseID ,
            @LessonName ,
            @Description ,
            @Status ,
            @LessonLength ,
            @Seq ,
            @MediaURL ,
            @MediaType ,
            @MediaLength ,
            @MediaWidth ,
            @MediaHeight ,
            @Content ,
            @Quiz ,
            @QuizLimit ,
            @QuizLength ,
            @PassingGrade ,
            @QuizWeight ,
            @IsPassQuiz            )

SET @mNewID = @@IDENTITY

SET @LessonID = @mNewID

GO