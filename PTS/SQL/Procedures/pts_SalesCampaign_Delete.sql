EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_Delete'
GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_Delete
   @SalesCampaignID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_SalesStep_DeleteSalesCampaign
   @SalesCampaignID

DELETE slc
FROM SalesCampaign AS slc
WHERE (slc.SalesCampaignID = @SalesCampaignID)


GO