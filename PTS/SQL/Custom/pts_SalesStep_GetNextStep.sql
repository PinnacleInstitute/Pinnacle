EXEC [dbo].pts_CheckProc 'pts_SalesStep_GetNextStep'
GO

CREATE PROCEDURE [dbo].pts_SalesStep_GetNextStep
@SalesStepID int,
@NextStep int OUTPUT	
AS

DECLARE @Next int, @SalesCampaignID int, @ID int 

SET @NextStep = 0

-- Get the specified SalesStep's next step
SELECT @Next = NextStep, @SalesCampaignID = SalesCampaignID FROM SalesStep WHERE SalesStepID = @SalesStepID

-- Find the next SalesStep within the same SalesCampaign
IF @Next > 0 AND @Next IS NOT NULL
BEGIN
	SELECT @ID = SalesStepID FROM SalesStep WHERE SalesCampaignID = @SalesCampaignID AND Seq = @Next
	IF @ID IS NOT NULL
	BEGIN
		SET @NextStep = @ID
	END
END

-- Check for fixed steps (-3 = Fallback, -4 = Closed, -5 = Dead)
IF @Next <= -3 AND @Next >= -5
BEGIN
	SET @NextStep = @Next * -1
END

GO

