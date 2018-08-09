EXEC [dbo].pts_CheckProc 'pts_Mail_ListSalesCampaign'
GO

CREATE PROCEDURE [dbo].pts_Mail_ListSalesCampaign
   @SalesCampaignID int
AS

SET NOCOUNT ON

SELECT      ml.MailID, 
         ml.Subject, 
         ml.MailDate
FROM Mail AS ml (NOLOCK)
WHERE (ml.SalesCampaignID = @SalesCampaignID)

ORDER BY   ml.MailDate DESC

GO