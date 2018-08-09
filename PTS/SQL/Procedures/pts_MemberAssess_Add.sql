EXEC [dbo].pts_CheckProc 'pts_MemberAssess_Add'
 GO

CREATE PROCEDURE [dbo].pts_MemberAssess_Add ( 
   @MemberAssessID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO MemberAssess (
            MemberID , 
            AssessmentID , 
            StartDate , 
            CompleteDate , 
            Status , 
            ExternalID , 
            Result , 
            Score , 
            TrainerScore , 
            CommStatus , 
            IsPrivate , 
            IsRemoved
            )
VALUES (
            @MemberID ,
            @AssessmentID ,
            @StartDate ,
            @CompleteDate ,
            @Status ,
            @ExternalID ,
            @Result ,
            @Score ,
            @TrainerScore ,
            @CommStatus ,
            @IsPrivate ,
            @IsRemoved            )

SET @mNewID = @@IDENTITY

SET @MemberAssessID = @mNewID

GO