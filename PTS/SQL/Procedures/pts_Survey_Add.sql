EXEC [dbo].pts_CheckProc 'pts_Survey_Add'
 GO

CREATE PROCEDURE [dbo].pts_Survey_Add ( 
   @SurveyID int OUTPUT,
   @OrgID int,
   @SurveyName nvarchar (60),
   @Description nvarchar (500),
   @Status int,
   @StartDate datetime,
   @EndDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Survey (
            OrgID , 
            SurveyName , 
            Description , 
            Status , 
            StartDate , 
            EndDate
            )
VALUES (
            @OrgID ,
            @SurveyName ,
            @Description ,
            @Status ,
            @StartDate ,
            @EndDate            )

SET @mNewID = @@IDENTITY

SET @SurveyID = @mNewID

GO