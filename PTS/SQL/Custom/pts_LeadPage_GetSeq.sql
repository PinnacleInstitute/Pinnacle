EXEC [dbo].pts_CheckProc 'pts_LeadPage_GetSeq'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_GetSeq
   @LeadCampaignID int ,
   @Seq int ,
   @Language nvarchar (6) ,
   @Result int OUTPUT
AS

SET NOCOUNT ONSET @Result = 0SELECT @Result = LeadPageID FROM LeadPageWHERE LeadCampaignID = @LeadCampaignID AND Status = 2 AND Language = @Language AND Seq = @Seq
GO