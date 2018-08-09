EXEC [dbo].pts_CheckProc 'pts_Block_BlockMsg'
GO

--DECLARE @Result int EXEC pts_Block_BlockMsg 1, 6, @Result OUTPUT PRINT @Result
--select * from Block

CREATE PROCEDURE [dbo].pts_Block_BlockMsg
   @ConsumerID int ,
   @MerchantID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @BlockID int, @Now datetime
SET @BlockID = 0
SET @Now = GETDATE()

SELECT @BlockID = BlockID FROM Block WHERE ConsumerID = @ConsumerID AND MerchantID = @MerchantID

IF @BlockID = 0
BEGIN
	--BlockID,ConsumerID,MerchantID,BlockDate,UserID
	EXEC pts_Block_Add @Result OUTPUT, @ConsumerID, @MerchantID, @Now, 1
END

GO