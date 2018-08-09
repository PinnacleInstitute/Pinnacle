EXEC [dbo].pts_CheckProc 'pts_Prospect_NewStep'
GO

-- Set the prospect to a new step, which is the seq within the same Sales Campaign
-- Lookup the new step and get it's actual SalesStepID and NextStep info
CREATE PROCEDURE [dbo].pts_Prospect_NewStep
   @ProspectID int,
   @Status int
AS

DECLARE @Now datetime, @SalesStepID int, @Step int 
DECLARE @SalesCampaignID int, @NextStep int, @Delay int, @AutoStep int, @EmailID int
DECLARE @NextChangeDate datetime, @NextChangeStatus int, @NextEmailDate datetime, @NextEmailID int

SET @Now = GETDATE()

-- If we have a custom step, get the SalesStepID for the Status 
IF @Status > 0
BEGIN
	SET @Step = @Status
	SET @Status = 0
	
--	--Get the Campaign for the Prospect
	SELECT @SalesCampaignID = SalesCampaignID FROM Prospect WHERE ProspectID = @ProspectID
	
--	--Lookup the @Step as the Seq within the same SalesCampaign
	SELECT @Status = SalesStepID FROM SalesStep WHERE SalesCampaignID = @SalesCampaignID AND Seq = @Step
END
-- If we have a fixed step (negative), get it's positive value for the Status 
IF @Status < 0 SET @Status = @Status * -1

IF @Status > 0  
BEGIN
	
--	-- Get the Sales Step identified by the Status
	SELECT @SalesCampaignID = SalesCampaignID, @NextStep = NextStep, @Delay = Delay, @AutoStep = AutoStep, @EmailID = EmailID
	FROM SalesStep WHERE SalesStepID = @Status
	
	IF @SalesCampaignID IS NOT NULL
	BEGIN
		SET @NextChangeStatus = 0
		SET @NextChangeDate = 0
		SET @NextEmailID = 0
		SET @NextEmailDate = 0
	
--		-- If we have an auto step, set the next email and date 
		IF @AutoStep > 0
		BEGIN
			SET @NextEmailID = @EmailID
			IF @NextEmailID > 0 SET @NextEmailDate = @Now
		END
--		-- If we have a next custom step, set the next status and date 
		IF @NextStep > 0
		BEGIN
--			--Lookup the @NextStep as the Seq within the same SalesCampaign
			SELECT @SalesStepID = SalesStepID FROM SalesStep 
			WHERE SalesCampaignID = @SalesCampaignID AND Seq = @NextStep
			IF @SalesStepID IS NOT NULL 
			BEGIN
				SET @NextChangeStatus = @SalesStepID
				SET @NextChangeDate = DATEADD(hour, @Delay, @Now)
			END
		END
--		-- If we have a next fixed step(negative), set the next status and date 
		IF @NextStep < 0
		BEGIN
			SET @NextChangeStatus = @NextStep * -1
			SET @NextChangeDate = DATEADD(hour, @Delay, @Now)
		END
	
--		-- Update the Prospect Status, ChangeStatus and ChangeDate
		UPDATE Prospect SET Status = @Status, ChangeStatus = @NextChangeStatus, 
			ChangeDate = @NextChangeDate, EmailID = @NextEmailID, EmailDate = @NextEmailDate 
		WHERE ProspectID = @ProspectID
	END
END

GO

