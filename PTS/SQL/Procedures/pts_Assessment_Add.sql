EXEC [dbo].pts_CheckProc 'pts_Assessment_Add'
 GO

CREATE PROCEDURE [dbo].pts_Assessment_Add ( 
   @AssessmentID int OUTPUT,
   @TrainerID int,
   @CompanyID int,
   @FirstQuestionCode int,
   @AssessmentName nvarchar (60),
   @Description nvarchar (500),
   @Courses varchar (50),
   @Assessments varchar (50),
   @AssessDate datetime,
   @Status int,
   @AssessmentType int,
   @NewURL varchar (200),
   @EditURL varchar (200),
   @ResultType int,
   @Formula varchar (100),
   @CustomCode int,
   @Takes int,
   @Delay int,
   @IsTrial bit,
   @IsPaid bit,
   @IsCertify bit,
   @AssessType int,
   @AssessLevel int,
   @AssessLength int,
   @ScoreFactor decimal (10, 6),
   @Rating int,
   @Grade int,
   @Points int,
   @TimeLimit int,
   @NoCertificate bit,
   @IsCustomCertificate bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Assessment (
            TrainerID , 
            CompanyID , 
            FirstQuestionCode , 
            AssessmentName , 
            Description , 
            Courses , 
            Assessments , 
            AssessDate , 
            Status , 
            AssessmentType , 
            NewURL , 
            EditURL , 
            ResultType , 
            Formula , 
            CustomCode , 
            Takes , 
            Delay , 
            IsTrial , 
            IsPaid , 
            IsCertify , 
            AssessType , 
            AssessLevel , 
            AssessLength , 
            ScoreFactor , 
            Rating , 
            Grade , 
            Points , 
            TimeLimit , 
            NoCertificate , 
            IsCustomCertificate
            )
VALUES (
            @TrainerID ,
            @CompanyID ,
            @FirstQuestionCode ,
            @AssessmentName ,
            @Description ,
            @Courses ,
            @Assessments ,
            @AssessDate ,
            @Status ,
            @AssessmentType ,
            @NewURL ,
            @EditURL ,
            @ResultType ,
            @Formula ,
            @CustomCode ,
            @Takes ,
            @Delay ,
            @IsTrial ,
            @IsPaid ,
            @IsCertify ,
            @AssessType ,
            @AssessLevel ,
            @AssessLength ,
            @ScoreFactor ,
            @Rating ,
            @Grade ,
            @Points ,
            @TimeLimit ,
            @NoCertificate ,
            @IsCustomCertificate            )

SET @mNewID = @@IDENTITY

SET @AssessmentID = @mNewID

GO