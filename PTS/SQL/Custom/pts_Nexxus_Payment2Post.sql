EXEC [dbo].pts_CheckProc 'pts_Nexxus_Payment2Post'
GO
--DECLARE @Result int EXEC pts_Nexxus_Payment2Post 1, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Payment2Post
   @Payment2ID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @Count int, @Status int, @CommStatus int 

SET @Count = 0

-- Get Payment Info
SELECT @Status = [Status], @CommStatus = CommStatus FROM Payment2 WHERE Payment2ID = @Payment2ID

-- Process Approved Payment2
IF @Status = 3
BEGIN
	-- If the payment is not bonused yet - calc bonuses
	IF @CommStatus = 1 EXEC pts_Commission_Company_21r @Payment2ID, @Count OUTPUT
	SET @Result = @Count
END

GO 
