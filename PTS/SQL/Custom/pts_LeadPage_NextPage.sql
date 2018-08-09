EXEC [dbo].pts_CheckProc 'pts_LeadPage_NextPage'
GO
 CREATE PROCEDURE [dbo].pts_LeadPage_NextPage@LeadCampaignID int ,@LeadPageID int ,@Language varchar (6),@Result int OUTPUTAS SET NOCOUNT ONSET @Result = 0IF @LeadPageID = 0BEGIN	SELECT TOP 1 @Result = LeadPageID FROM LeadPage	WHERE LeadCampaignID = @LeadCampaignID AND Status = 2 AND Language = @Language	ORDER BY SeqENDELSEBEGIN 	DECLARE @Seq int 	SELECT @Seq = Seq FROM LeadPage WHERE LeadPageID = @LeadPageID 	SELECT TOP 1 @Result = LeadPageID FROM LeadPage 	WHERE LeadCampaignID = @LeadCampaignID AND Status = 2 AND Language = @Language AND Seq > @SeqEND
GO
