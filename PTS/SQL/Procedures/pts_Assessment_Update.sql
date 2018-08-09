EXEC [dbo].pts_CheckProc 'pts_Assessment_Update'
 GO

CREATE PROCEDURE [dbo].pts_Assessment_Update ( 
   @AssessmentID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE asm
SET asm.TrainerID = @TrainerID ,
   asm.CompanyID = @CompanyID ,
   asm.FirstQuestionCode = @FirstQuestionCode ,
   asm.AssessmentName = @AssessmentName ,
   asm.Description = @Description ,
   asm.Courses = @Courses ,
   asm.Assessments = @Assessments ,
   asm.AssessDate = @AssessDate ,
   asm.Status = @Status ,
   asm.AssessmentType = @AssessmentType ,
   asm.NewURL = @NewURL ,
   asm.EditURL = @EditURL ,
   asm.ResultType = @ResultType ,
   asm.Formula = @Formula ,
   asm.CustomCode = @CustomCode ,
   asm.Takes = @Takes ,
   asm.Delay = @Delay ,
   asm.IsTrial = @IsTrial ,
   asm.IsPaid = @IsPaid ,
   asm.IsCertify = @IsCertify ,
   asm.AssessType = @AssessType ,
   asm.AssessLevel = @AssessLevel ,
   asm.AssessLength = @AssessLength ,
   asm.ScoreFactor = @ScoreFactor ,
   asm.Rating = @Rating ,
   asm.Grade = @Grade ,
   asm.Points = @Points ,
   asm.TimeLimit = @TimeLimit ,
   asm.NoCertificate = @NoCertificate ,
   asm.IsCustomCertificate = @IsCustomCertificate
FROM Assessment AS asm
WHERE asm.AssessmentID = @AssessmentID

GO