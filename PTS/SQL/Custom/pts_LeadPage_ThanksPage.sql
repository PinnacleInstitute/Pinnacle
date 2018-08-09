EXEC [dbo].pts_CheckProc 'pts_LeadPage_ThanksPage'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_ThanksPage
   @LeadCampaignID int ,
   @Language varchar (6),
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

SELECT TOP 1 @Result = LeadPageID FROM LeadPage
WHERE LeadCampaignID = @LeadCampaignID AND Status = 4 AND Language = @Language

GO
