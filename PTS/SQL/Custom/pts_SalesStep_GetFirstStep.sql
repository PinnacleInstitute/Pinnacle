EXEC [dbo].pts_CheckProc 'pts_SalesStep_GetFirstStep'
GO

CREATE PROCEDURE [dbo].pts_SalesStep_GetFirstStep
   @SalesCampaignID int ,
   @FirstStep int OUTPUT
AS

SET NOCOUNT ON

SELECT TOP 1 @FirstStep = SalesStepID 
FROM SalesStep
WHERE SalesCampaignID = @SalesCampaignID
ORDER BY Seq 

IF @FirstStep IS NULL
	SET @FirstStep = 1
	
GO