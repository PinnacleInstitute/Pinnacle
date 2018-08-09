EXEC [dbo].pts_CheckProc 'pts_Survey_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Survey_Fetch ( 
   @SurveyID int,
   @OrgID int OUTPUT,
   @OrgName nvarchar (60) OUTPUT,
   @CompanyID int OUTPUT,
   @SurveyName nvarchar (60) OUTPUT,
   @Description nvarchar (500) OUTPUT,
   @Status int OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OrgID = su.OrgID ,
   @OrgName = og.OrgName ,
   @CompanyID = og.CompanyID ,
   @SurveyName = su.SurveyName ,
   @Description = su.Description ,
   @Status = su.Status ,
   @StartDate = su.StartDate ,
   @EndDate = su.EndDate
FROM Survey AS su (NOLOCK)
LEFT OUTER JOIN Org AS og (NOLOCK) ON (su.OrgID = og.OrgID)
WHERE su.SurveyID = @SurveyID

GO