EXEC [dbo].pts_CheckProc 'pts_Assessment_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Assessment_Fetch ( 
   @AssessmentID int,
   @TrainerID int OUTPUT,
   @CompanyID int OUTPUT,
   @FirstQuestionCode int OUTPUT,
   @AssessmentName nvarchar (60) OUTPUT,
   @Description nvarchar (500) OUTPUT,
   @Courses varchar (50) OUTPUT,
   @Assessments varchar (50) OUTPUT,
   @AssessDate datetime OUTPUT,
   @Status int OUTPUT,
   @AssessmentType int OUTPUT,
   @NewURL varchar (200) OUTPUT,
   @EditURL varchar (200) OUTPUT,
   @ResultType int OUTPUT,
   @Formula varchar (100) OUTPUT,
   @CustomCode int OUTPUT,
   @Takes int OUTPUT,
   @Delay int OUTPUT,
   @IsTrial bit OUTPUT,
   @IsPaid bit OUTPUT,
   @IsCertify bit OUTPUT,
   @AssessType int OUTPUT,
   @AssessLevel int OUTPUT,
   @AssessLength int OUTPUT,
   @ScoreFactor decimal (10, 6) OUTPUT,
   @Rating int OUTPUT,
   @Grade int OUTPUT,
   @Points int OUTPUT,
   @TimeLimit int OUTPUT,
   @NoCertificate bit OUTPUT,
   @IsCustomCertificate bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @TrainerID = asm.TrainerID ,
   @CompanyID = asm.CompanyID ,
   @FirstQuestionCode = asm.FirstQuestionCode ,
   @AssessmentName = asm.AssessmentName ,
   @Description = asm.Description ,
   @Courses = asm.Courses ,
   @Assessments = asm.Assessments ,
   @AssessDate = asm.AssessDate ,
   @Status = asm.Status ,
   @AssessmentType = asm.AssessmentType ,
   @NewURL = asm.NewURL ,
   @EditURL = asm.EditURL ,
   @ResultType = asm.ResultType ,
   @Formula = asm.Formula ,
   @CustomCode = asm.CustomCode ,
   @Takes = asm.Takes ,
   @Delay = asm.Delay ,
   @IsTrial = asm.IsTrial ,
   @IsPaid = asm.IsPaid ,
   @IsCertify = asm.IsCertify ,
   @AssessType = asm.AssessType ,
   @AssessLevel = asm.AssessLevel ,
   @AssessLength = asm.AssessLength ,
   @ScoreFactor = asm.ScoreFactor ,
   @Rating = asm.Rating ,
   @Grade = asm.Grade ,
   @Points = asm.Points ,
   @TimeLimit = asm.TimeLimit ,
   @NoCertificate = asm.NoCertificate ,
   @IsCustomCertificate = asm.IsCustomCertificate
FROM Assessment AS asm (NOLOCK)
WHERE asm.AssessmentID = @AssessmentID

GO