EXEC [dbo].pts_CheckProc 'pts_Mail_EnumUserTemplate'
GO

CREATE PROCEDURE [dbo].pts_Mail_EnumUserTemplate
   @SalesCampaignID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ml.MailID AS 'ID', 
         ml.Subject AS 'Name'
FROM Mail AS ml (NOLOCK)
WHERE (ml.SalesCampaignID = @SalesCampaignID)

ORDER BY   ml.MailDate DESC

GO