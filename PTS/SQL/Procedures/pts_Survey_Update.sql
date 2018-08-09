EXEC [dbo].pts_CheckProc 'pts_Survey_Update'
 GO

CREATE PROCEDURE [dbo].pts_Survey_Update ( 
   @SurveyID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE su
SET su.OrgID = @OrgID ,
   su.SurveyName = @SurveyName ,
   su.Description = @Description ,
   su.Status = @Status ,
   su.StartDate = @StartDate ,
   su.EndDate = @EndDate
FROM Survey AS su
WHERE su.SurveyID = @SurveyID

GO