EXEC [dbo].pts_CheckProc 'pts_SalesStep_List'
GO

CREATE PROCEDURE [dbo].pts_SalesStep_List
   @SalesCampaignID int
AS

SET NOCOUNT ON

SELECT      sls.SalesStepID, 
         sls.SalesStepName, 
         sls.Description, 
         sls.Seq, 
         sls.AutoStep, 
         sls.NextStep, 
         sls.Delay, 
         sls.DateNo, 
         sls.IsBoard, 
         sls.BoardRate, 
         sls.Length
FROM SalesStep AS sls (NOLOCK)
WHERE (sls.SalesCampaignID = @SalesCampaignID)
 AND (sls.SalesCampaignID <> 0)

ORDER BY   sls.Seq

GO