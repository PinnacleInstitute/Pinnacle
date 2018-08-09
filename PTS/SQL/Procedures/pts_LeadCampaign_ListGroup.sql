EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_ListGroup
   @GroupID int ,
   @PageType int
AS

SET NOCOUNT ON

SELECT      lc.LeadCampaignID, 
         lc.LeadCampaignName, 
         lc.Image, 
         lc.Status, 
         lc.PageType, 
         lc.Objective
FROM LeadCampaign AS lc (NOLOCK)
WHERE (lc.GroupID = @GroupID)
 AND (lc.PageType = @PageType)

ORDER BY   lc.Seq , lc.LeadCampaignName

GO