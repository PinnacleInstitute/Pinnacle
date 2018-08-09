EXEC [dbo].pts_CheckProc 'pts_MemberAssess_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MemberAssess_Fetch ( 
   @MemberAssessID int,
   @MemberID int OUTPUT,
   @AssessmentID int OUTPUT,
   @AssessmentName nvarchar (60) OUTPUT,
   @IsCertify bit OUTPUT,
   @NoCertificate bit OUTPUT,
   @IsCustomCertificate bit OUTPUT,
   @CompanyID int OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @StartDate datetime OUTPUT,
   @CompleteDate datetime OUTPUT,
   @Status int OUTPUT,
   @ExternalID nvarchar (30) OUTPUT,
   @Result nvarchar (1000) OUTPUT,
   @Score decimal (10, 6) OUTPUT,
   @TrainerScore int OUTPUT,
   @CommStatus int OUTPUT,
   @IsPrivate bit OUTPUT,
   @IsRemoved bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ma.MemberID ,
   @AssessmentID = ma.AssessmentID ,
   @AssessmentName = asm.AssessmentName ,
   @IsCertify = asm.IsCertify ,
   @NoCertificate = asm.NoCertificate ,
   @IsCustomCertificate = asm.IsCustomCertificate ,
   @CompanyID = me.CompanyID ,
   @MemberName = me.CompanyName ,
   @StartDate = ma.StartDate ,
   @CompleteDate = ma.CompleteDate ,
   @Status = ma.Status ,
   @ExternalID = ma.ExternalID ,
   @Result = ma.Result ,
   @Score = ma.Score ,
   @TrainerScore = ma.TrainerScore ,
   @CommStatus = ma.CommStatus ,
   @IsPrivate = ma.IsPrivate ,
   @IsRemoved = ma.IsRemoved
FROM MemberAssess AS ma (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (ma.MemberID = me.MemberID)
LEFT OUTER JOIN Assessment AS asm (NOLOCK) ON (ma.AssessmentID = asm.AssessmentID)
WHERE ma.MemberAssessID = @MemberAssessID

GO