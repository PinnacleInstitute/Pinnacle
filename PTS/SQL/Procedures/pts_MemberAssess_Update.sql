EXEC [dbo].pts_CheckProc 'pts_MemberAssess_Update'
 GO

CREATE PROCEDURE [dbo].pts_MemberAssess_Update ( 
   @MemberAssessID int,
   @MemberID int,
   @AssessmentID int,
   @StartDate datetime,
   @CompleteDate datetime,
   @Status int,
   @ExternalID nvarchar (30),
   @Result nvarchar (1000),
   @Score decimal (10, 6),
   @TrainerScore int,
   @CommStatus int,
   @IsPrivate bit,
   @IsRemoved bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ma
SET ma.MemberID = @MemberID ,
   ma.AssessmentID = @AssessmentID ,
   ma.StartDate = @StartDate ,
   ma.CompleteDate = @CompleteDate ,
   ma.Status = @Status ,
   ma.ExternalID = @ExternalID ,
   ma.Result = @Result ,
   ma.Score = @Score ,
   ma.TrainerScore = @TrainerScore ,
   ma.CommStatus = @CommStatus ,
   ma.IsPrivate = @IsPrivate ,
   ma.IsRemoved = @IsRemoved
FROM MemberAssess AS ma
WHERE ma.MemberAssessID = @MemberAssessID

GO