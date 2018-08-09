EXEC [dbo].pts_CheckProc 'pts_Course_Add'
GO

CREATE PROCEDURE [dbo].pts_Course_Add
   @CourseID int OUTPUT,
   @CourseCategoryID int,
   @TrainerID int,
   @CompanyID int,
   @ExamID int,
   @CourseName nvarchar (80),
   @Status int,
   @CourseType int,
   @CourseLevel int,
   @Description nvarchar (1000),
   @Language nvarchar (20),
   @CourseLength int,
   @CourseDate datetime,
   @IsPaid bit,
   @Price money,
   @Grp int,
   @Seq int,
   @PassingGrade int,
   @Rating int,
   @RatingCnt int,
   @Classes int,
   @Video bit,
   @Audio bit,
   @Quiz bit,
   @Reference varchar (15),
   @ScoreFactor decimal (10, 6),
   @NoCertificate bit,
   @NoEvaluation bit,
   @IsCustomCertificate bit,
   @Credit money,
   @ExamWeight int,
   @Pre varchar (20),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO Course (
            CourseCategoryID , 
            TrainerID , 
            CompanyID , 
            ExamID , 
            CourseName , 
            Status , 
            CourseType , 
            CourseLevel , 
            Description , 
            Language , 
            CourseLength , 
            CourseDate , 
            IsPaid , 
            Price , 
            Grp , 
            Seq , 
            PassingGrade , 
            Rating , 
            RatingCnt , 
            Classes , 
            Video , 
            Audio , 
            Quiz , 
            Reference , 
            ScoreFactor , 
            NoCertificate , 
            NoEvaluation , 
            IsCustomCertificate , 
            Credit , 
            ExamWeight , 
            Pre

            )
VALUES (
            @CourseCategoryID ,
            @TrainerID ,
            @CompanyID ,
            @ExamID ,
            @CourseName ,
            @Status ,
            @CourseType ,
            @CourseLevel ,
            @Description ,
            @Language ,
            @CourseLength ,
            @CourseDate ,
            @IsPaid ,
            @Price ,
            @Grp ,
            @Seq ,
            @PassingGrade ,
            @Rating ,
            @RatingCnt ,
            @Classes ,
            @Video ,
            @Audio ,
            @Quiz ,
            @Reference ,
            @ScoreFactor ,
            @NoCertificate ,
            @NoEvaluation ,
            @IsCustomCertificate ,
            @Credit ,
            @ExamWeight ,
            @Pre
            )

SET @mNewID = @@IDENTITY
SET @CourseID = @mNewID
IF ((@CourseCategoryID > 0))
   BEGIN
   EXEC pts_CourseCategory_Update_Counters
      @CourseCategoryID

   END

GO