EXEC [dbo].pts_CheckProc 'pts_LeadPage_GetSeq'
GO

CREATE PROCEDURE [dbo].pts_LeadPage_GetSeq
   @LeadCampaignID int ,
   @Seq int ,
   @Language nvarchar (6) ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
GO