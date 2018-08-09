EXEC [dbo].pts_CheckProc 'pts_DripPage_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_DripPage_Fetch ( 
   @DripPageID int,
   @DripCampaignID int OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @Days int OUTPUT,
   @IsCC bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @DripCampaignID = dep.DripCampaignID ,
   @Subject = dep.Subject ,
   @Status = dep.Status ,
   @Days = dep.Days ,
   @IsCC = dep.IsCC
FROM DripPage AS dep (NOLOCK)
WHERE dep.DripPageID = @DripPageID

GO