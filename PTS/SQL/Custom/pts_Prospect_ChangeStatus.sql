EXEC [dbo].pts_CheckProc 'pts_Prospect_ChangeStatus'
GO

--EXEC pts_Prospect_ChangeStatus

CREATE PROCEDURE [dbo].pts_Prospect_ChangeStatus
AS

DECLARE @Now datetime, @NoteID int
DECLARE @ProspectID int, @ChangeStatus int, @AutoStep int, @EmailID int, @DateNo int
DECLARE @SalesStepID int, @SalesCampaignID int, @Delay int, @NextStep int, @SalesStepName varchar(100) 
DECLARE @NextChangeDate datetime, @NextChangeStatus int, @NextEmailDate datetime, @NextEmailID int

SET @Now = GETDATE()

--Get all prospects that have a past change status date
-- also get the info for the next step
DECLARE Prospect_cursor CURSOR FOR 
SELECT  pr.ProspectID, pr.ChangeStatus, ss.SalesCampaignID, 
ss.Delay, ss.NextStep, ss.SalesStepName, ss.AutoStep, ss.EmailID, ss.DateNo
FROM Prospect AS pr
JOIN SalesStep AS ss ON pr.ChangeStatus = ss.SalesStepID
WHERE pr.ChangeDate > 0 AND pr.ChangeDate <= @Now AND pr.ChangeStatus > 0

OPEN Prospect_cursor

FETCH NEXT FROM Prospect_cursor INTO @ProspectID, @ChangeStatus, @SalesCampaignID, @Delay, @NextStep, @SalesStepName, @AutoStep, @EmailID, @DateNo

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @NextChangeStatus = 0
	SET @NextChangeDate = 0
	SET @NextEmailID = 0
	SET @NextEmailDate = 0

--	-- If we have an auto step, set the next email and date 
	IF @AutoStep > 0
	BEGIN
		SET @NextEmailID = @EmailID
		IF @NextEmailID > 0 SET @NextEmailDate = @Now
	END
--	-- If we have a next custom step, set the next change status and date 
	IF @NextStep > 0
	BEGIN
--		--Lookup the @NextStep as the Seq within the same SalesCampaign
		SELECT @SalesStepID = SalesStepID FROM SalesStep WHERE SalesCampaignID = @SalesCampaignID AND Seq = @NextStep
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
	UPDATE Prospect SET Status = @ChangeStatus, ChangeStatus = @NextChangeStatus, ChangeDate = @NextChangeDate,
		EmailID = @NextEmailID, EmailDate = @NextEmailDate WHERE ProspectID = @ProspectID

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

--	-- Add Note for Change
--	SET @SalesStepName = 'Status Changed to ' + @SalesStepName
--	IF @NextEmailID > 0 SET @SalesStepName = @SalesStepName + '; Set Next Email to #' + CAST(@NextEmailID AS VARCHAR(10))

--      --  @NoteID,@OwnerType,@OwnerID,@AuthUserID,@NoteDate,@Notes,@IsLocked,@IsFrozen,@IsReminder,@UserID
--	EXEC pts_Note_Add @NoteID OUTPUT, 81, @ProspectID, 1, @Now, @SalesStepName, 1,0,0,1
	
	FETCH NEXT FROM Prospect_cursor INTO @ProspectID, @ChangeStatus, @SalesCampaignID, @Delay, @NextStep, @SalesStepName, @AutoStep, @EmailID, @DateNo
END

CLOSE Prospect_cursor
DEALLOCATE Prospect_cursor

GO