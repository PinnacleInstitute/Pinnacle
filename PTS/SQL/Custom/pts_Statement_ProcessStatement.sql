EXEC [dbo].pts_CheckProc 'pts_Statement_ProcessStatement'
GO

CREATE PROCEDURE [dbo].pts_Statement_ProcessStatement
   @StatementID int ,
   @Status int ,
   @Result nvarchar (100) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Payment2ID int, @Today datetime
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

--Process Paid Statement
IF @StatementID > 0
BEGIN
	IF @Status > 0
		UPDATE Statement SET Status = @Status, PaidDate = @Today WHERE StatementID = @StatementID 
	ELSE
		SELECT @Status = Status FROM Statement WHERE StatementID = @StatementID 

--	If Approved Statement/Invoice
	IF @Status = 3
	BEGIN
		-- HOLD pending rewards for payments on this statement
--		UPDATE re SET Status = 4
-- RELEASE CASH REWARD POINTS IMMEDIATELY (TEMPORARY)
		UPDATE re SET Status = 3
		FROM Reward AS re
		JOIN Payment2 AS pa ON re.Payment2ID = pa.Payment2ID
		WHERE pa.StatementID = @StatementID AND re.Status = 2
		
		-- Process each approved order / Payment2
		DECLARE Payment2_Cursor CURSOR LOCAL STATIC FOR 
		SELECT Payment2ID FROM Payment2 WHERE StatementID = @StatementID AND Status = 2

		OPEN Payment2_Cursor
		FETCH NEXT FROM Payment2_Cursor INTO @Payment2ID
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
			UPDATE Payment2 SET Status = 3 WHERE Payment2ID = @Payment2ID
			EXEC pts_Nexxus_Payment2Post @Payment2ID, @Result OUTPUT
			
			FETCH NEXT FROM Payment2_Cursor INTO @Payment2ID
		END
		CLOSE Payment2_Cursor
		DEALLOCATE Payment2_Cursor
	END
END

--Undo Paid Statement
IF @StatementID < 0
BEGIN
	SET @StatementID = ABS(@StatementID)

	IF @Status > 0
		UPDATE Statement SET Status = @Status WHERE StatementID = @StatementID 
	ELSE
		SELECT @Status = Status FROM Statement WHERE StatementID = @StatementID 

	IF @Status <> 3
	BEGIN
		-- Undo pending payments on this statement
		UPDATE Payment2 SET Status = 2 WHERE StatementID = @StatementID AND Status = 3

		-- Undo pending rewards for payments on this statement
		UPDATE re SET Status = 2
		FROM Rewards AS re
		JOIN Payment2 AS pa ON re.Payment2ID = pa.Payment2ID
		WHERE pa.StatementID = @StatementID AND re.Status = 3
	END
END


GO