EXEC [dbo].pts_CheckProc 'pts_GCR_UpdatePendingPayment'
GO

--declare @Result varchar(1000) EXEC pts_GCR_UpdatePendingPayment 12046, @Result output print @Result

CREATE PROCEDURE [dbo].pts_GCR_UpdatePendingPayment
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @PaymentID int, @Title int
SET @PaymentID = -1
SET @Title = 0

SELECT TOP 1 @PaymentID = PaymentID FROM Payment Where OwnerType = 4 AND OwnerID = @MemberID AND Status < 3 ORDER BY PayDate DESC   

IF @PaymentID > 0
BEGIN
	DECLARE @Price money, @Options2 VARCHAR(100), @Purpose VARCHAR(50)
	SELECT @Price = Price, @Options2 = Options2 FROM Member WHERE MemberID = @MemberID
	
	--	Only process Autoships
	EXEC pts_GCR_ValidAutoShip @Options2, @Purpose OUTPUT
	
	IF @Purpose <> ''
	BEGIN
		DECLARE @cnt int
		SELECT @cnt = COUNT(*) FROM Payment Where OwnerType = 4 AND OwnerID = @MemberID
--		Check if this is their intial enrollment payment
		IF @cnt = 1
		BEGIN
			IF @Purpose = '202' BEGIN SET @Purpose = '102' SET @Title = 2 END
			IF @Purpose = '203' BEGIN SET @Purpose = '103' SET @Title = 3 END
			IF @Purpose = '204' BEGIN SET @Purpose = '104' SET @Title = 4 END
			IF @Purpose = '205' BEGIN SET @Purpose = '105' SET @Title = 5 END
			IF @Purpose = '206' BEGIN SET @Purpose = '106' SET @Title = 5 END
			IF @Purpose = '207' BEGIN SET @Purpose = '107' SET @Title = 5 END
			IF @Purpose = '208' BEGIN SET @Purpose = '108' SET @Title = 5 END
			
			IF @Title > 0 UPDATE Member SET Title = @Title WHERE MemberID = @MemberID
		END
		UPDATE Payment SET Amount = @Price, Total = @Price, Credit = 0, Purpose = @Purpose WHERE PaymentID = @PaymentID	
		SET @Result = '1'
	END
END
ELSE
BEGIN
--	No Payments for this member - create a new payment 
	EXEC pts_GCR_PaymentMember @MemberID, 0,0,0,0,0,'', @Result OUTPUT
END

GO

