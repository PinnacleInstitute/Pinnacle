EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_Add'
 GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_Add ( 
   @AssessQuestionID int OUTPUT,
   @AssessmentID int,
   @QuestionCode int,
   @Question nvarchar (1000),
   @Description nvarchar (2000),
   @Grp int,
   @Seq int,
   @QuestionType int,
   @RankMin int,
   @RankMax int,
   @ResultType int,
   @Answer int,
   @Points int,
   @NextType int,
   @NextQuestion int,
   @Formula varchar (100),
   @CustomCode int,
   @MultiSelect bit,
   @MediaType int,
   @MediaFile varchar (80),
   @Courses varchar (50),
   @Status int,
   @Discrimination decimal (10, 8),
   @Difficulty decimal (10, 8),
   @Guessing decimal (10, 8),
   @UseCount int,
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
   FROM AssessQuestion (NOLOCK)
   WHERE AssessmentID = @AssessmentID
   SET @Seq = @Seq + 10
END

INSERT INTO AssessQuestion (
            AssessmentID , 
            QuestionCode , 
            Question , 
            Description , 
            Grp , 
            Seq , 
            QuestionType , 
            RankMin , 
            RankMax , 
            ResultType , 
            Answer , 
            Points , 
            NextType , 
            NextQuestion , 
            Formula , 
            CustomCode , 
            MultiSelect , 
            MediaType , 
            MediaFile , 
            Courses , 
            Status , 
            Discrimination , 
            Difficulty , 
            Guessing , 
            UseCount
            )
VALUES (
            @AssessmentID ,
            @QuestionCode ,
            @Question ,
            @Description ,
            @Grp ,
            @Seq ,
            @QuestionType ,
            @RankMin ,
            @RankMax ,
            @ResultType ,
            @Answer ,
            @Points ,
            @NextType ,
            @NextQuestion ,
            @Formula ,
            @CustomCode ,
            @MultiSelect ,
            @MediaType ,
            @MediaFile ,
            @Courses ,
            @Status ,
            @Discrimination ,
            @Difficulty ,
            @Guessing ,
            @UseCount            )

SET @mNewID = @@IDENTITY

SET @AssessQuestionID = @mNewID

GO