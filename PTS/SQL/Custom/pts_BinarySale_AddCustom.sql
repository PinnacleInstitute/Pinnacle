EXEC [dbo].pts_CheckProc 'pts_BinarySale_AddCustom'
GO

--EXEC pts_BinarySale_AddCustom 7932, 1, 50

CREATE PROCEDURE [dbo].pts_BinarySale_AddCustom
   @MemberID int,
   @SaleType int,
   @Amount money
AS

SET NOCOUNT ON

DECLARE @Sponsor3ID int, @FirstMemberID int

-- Process New Sale - Accumulate upline
IF @SaleType = 1
BEGIN
	SET @FirstMemberID = @MemberID
	WHILE @MemberID > 0
	BEGIN
		SET @Sponsor3ID = -1
		SELECT @Sponsor3ID = Sponsor3ID	FROM Member WHERE MemberID = @MemberID
		IF @Sponsor3ID >= 0
		BEGIN
			UPDATE Member SET QV4 = QV4 + @Amount WHERE MemberID = @MemberID
		END	
		SET @MemberID = @Sponsor3ID
--		Prevent a Loop
		IF @MemberID = @FirstMemberID SET @MemberID = 0
	END
END

-- Process Bonus - Remove from Member Left and Right side
IF @SaleType = 2
BEGIN
	UPDATE Member SET QV4 = QV4 - @Amount FROM Member WHERE Sponsor3ID = @MemberID AND Status > 0 -- AND Status >= 1 AND Status <= 4
END

-- Process Refund or Expired - deduct from upline
IF @SaleType = 3 OR @SaleType = 4
BEGIN
	SET @FirstMemberID = @MemberID
	WHILE @MemberID > 0
	BEGIN
		SET @Sponsor3ID = -1
		SELECT @Sponsor3ID = Sponsor3ID	FROM Member WHERE MemberID = @MemberID
		IF @Sponsor3ID >= 0
		BEGIN
			UPDATE Member SET QV4 = QV4 - @Amount WHERE MemberID = @MemberID
		END	
		SET @MemberID = @Sponsor3ID
--		Prevent a Loop
		IF @MemberID = @FirstMemberID SET @MemberID = 0
	END
END

GO
