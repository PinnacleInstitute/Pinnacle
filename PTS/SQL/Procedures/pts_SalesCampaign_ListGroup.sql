EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_ListGroup
   @GroupID int
AS

SET NOCOUNT ON

SELECT      slc.SalesCampaignID, 
         slc.SalesCampaignName, 
         slc.Seq, 
         slc.IsCopyURL, 
         slc.CopyURL
FROM SalesCampaign AS slc (NOLOCK)
WHERE (slc.GroupID = @GroupID)

ORDER BY   slc.Seq

GO