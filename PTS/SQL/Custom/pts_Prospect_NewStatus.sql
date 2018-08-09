EXEC [dbo].pts_CheckProc 'pts_Prospect_NewStatus'
GO

-- Set the prospect to a new status, which is the SalesStepID within the same Sales Campaign
-- Lookup the new SalesStepID and get it's actual SalesStepID and NextStep info
CREATE PROCEDURE [dbo].pts_Prospect_NewStatus
   @ProspectID int,
   @Status int
AS

DECLARE @Now datetime, @SalesStepID int 
DECLARE @SalesCampaignID int, @NextStep int, @Delay int, @AutoStep int, @EmailID int, @DateNo int
DECLARE @NextChangeDate datetime, @NextChangeStatus int, @NextEmailDate datetime, @NextEmailID int

SET @Now = GETDATE()
SET @SalesCampaignID = 0

-- Get the Sales Step identified by the Status
SELECT @SalesCampaignID = SalesCampaignID, @NextStep = NextStep, @Delay = Delay, @AutoStep = AutoStep, @EmailID = EmailID, @DateNo = DateNo
FROM SalesStep WHERE SalesStepID = @Status

IF @SalesCampaignID > 0
BEGIN
	SET @NextChangeStatus = 0
	SET @NextChangeDate = 0
	SET @NextEmailID = 0
	SET @NextEmailDate = 0

--	-- If we have an auto step, set the next email and date 
	IF @AutoStep = 1
	BEGIN
		SET @NextEmailID = @EmailID
		IF @NextEmailID > 0 SET @NextEmailDate = @Now
	END
--	-- If we have a next custom step, set the next status and date 
	IF @NextStep > 0
	BEGIN
--		--Lookup the @NextStep as the Seq within the same SalesCampaign
		SELECT @SalesStepID = SalesStepID FROM SalesStep 
		WHERE SalesCampaignID = @SalesCampaignID AND Seq = @NextStep
		IF @SalesStepID IS NOT NULL 
		BEGIN
			SET @NextChangeStatus = @SalesStepID
			SET @NextChangeDate = DATEADD(hour, @Delay, @Now)
		END
	END
--	-- If we have a next fixed step(negative), set the next status and date 
	IF @NextStep < 0
	BEGIN
		SET @NextChangeStatus = @NextStep * -1
		SET @NextChangeDate = DATEADD(hour, @Delay, @Now)
	END

--	-- Update the Prospect Status, ChangeStatus and ChangeDate
	UPDATE Prospect SET Status = @Status, ChangeStatus = @NextChangeStatus, 
		ChangeDate = @NextChangeDate, EmailID = @NextEmailID, EmailDate = @NextEmailDate 
	WHERE ProspectID = @ProspectID

	IF @DateNo > 0
	BEGIN
		IF @DateNo = 1 UPDATE Prospect SET Date1 = @Now WHERE ProspectID = @ProspectID AND Date1 = 0
		IF @DateNo = 2 UPDATE Prospect SET Date2 = @Now WHERE ProspectID = @ProspectID AND Date2 = 0
		IF @DateNo = 3 UPDATE Prospect SET Date3 = @Now WHERE ProspectID = @ProspectID AND Date3 = 0
		IF @DateNo = 4 UPDATE Prospect SET Date4 = @Now WHERE ProspectID = @ProspectID AND Date4 = 0
		IF @DateNo = 5 UPDATE Prospect SET Date5 = @Now WHERE ProspectID = @ProspectID AND Date5 = 0
		IF @DateNo = 6 UPDATE Prospect SET Date6 = @Now WHERE ProspectID = @ProspectID AND Date6 = 0
		IF @DateNo = 7 UPDATE Prospect SET Date7 = @Now WHERE ProspectID = @ProspectID AND Date7 = 0
		IF @DateNo = 8 UPDATE Prospect SET Date8 = @Now WHERE ProspectID = @ProspectID AND Date8 = 0
		IF @DateNo = 9 UPDATE Prospect SET Date9 = @Now WHERE ProspectID = @ProspectID AND Date9 = 0
		IF @DateNo = 10 UPDATE Prospect SET Date10 = @Now WHERE ProspectID = @ProspectID AND Date10 = 0
	END
END
ELSE
BEGIN
--	-- Clear info
	UPDATE Prospect SET ChangeStatus = 0, ChangeDate = 0, EmailID = 0, EmailDate = 0 WHERE ProspectID = @ProspectID

--	-- Update standard statuses
	IF @Status = 3 UPDATE Prospect SET FBDate = @Now WHERE ProspectID = @ProspectID AND FBDate = 0
	IF @Status = 4 UPDATE Prospect SET CloseDate = @Now WHERE ProspectID = @ProspectID AND CloseDate = 0
	IF @Status = 5 UPDATE Prospect SET DeadDate = @Now WHERE ProspectID = @ProspectID AND DeadDate = 0
END

GO

