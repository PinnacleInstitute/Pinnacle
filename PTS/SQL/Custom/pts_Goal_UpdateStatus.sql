EXEC [dbo].pts_CheckProc 'pts_Goal_UpdateStatus'
GO

CREATE PROCEDURE [dbo].pts_Goal_UpdateStatus
   @GoalID int ,
   @Status int ,
   @ActQty int
AS

SET NOCOUNT ON

DECLARE @Now datetime
SET @Now = GETDATE()

IF @Status <= 2  
BEGIN
	UPDATE Goal Set Status = @Status, ActQty = @ActQty, CommitDate = @Now WHERE GoalID = @GoalID
END
IF @Status = 3  
BEGIN
	UPDATE Goal 
	SET Status = @Status,
		ActQty = @ActQty, 
	    CompleteDate = @Now, 
	    Variance = DATEDIFF(day, CommitDate, @Now), 
	    RemindDate = '' 
	WHERE GoalID = @GoalID
END

GO
