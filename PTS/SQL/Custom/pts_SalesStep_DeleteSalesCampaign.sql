EXEC [dbo].pts_CheckProc 'pts_SalesStep_DeleteSalesCampaign'
GO

CREATE PROCEDURE [dbo].pts_SalesStep_DeleteSalesCampaign
   @SalesCampaignID int
AS

DELETE SalesStep WHERE SalesCampaignID = @SalesCampaignID

GO