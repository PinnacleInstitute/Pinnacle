EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_List'
GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      slc.SalesCampaignID, 
         slc.SalesCampaignName, 
         slc.Seq, 
         slc.IsCopyURL, 
         slc.CopyURL
FROM SalesCampaign AS slc (NOLOCK)
WHERE (slc.CompanyID = @CompanyID)

ORDER BY   slc.Seq

GO