EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom'
GO

--EXEC pts_SalesOrder_Custom 2, 8241
--select * from salesorder where salesorderid = 8241
--select * from salesitem where salesorderid = 8241

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON

DECLARE @MemberID int, @BV money, @BVItems money, @SponsorID int, @IDS varchar(8000), @IDSTR varchar(10)  

----------------------------------------------------------------------------------------------------------
-- recaclulate order BV and accumulate member and upline BV and QV 
----------------------------------------------------------------------------------------------------------
IF @Status = 1
BEGIN 

--	get total BV from order items
	SELECT @BVItems = SUM(BV*Quantity) FROM SalesItem WHERE SalesOrderID = @SalesOrderID

--	get the member and BV for this order
	SELECT @MemberID = MemberID, @BV = BV FROM SalesOrder WHERE SalesOrderID = @SalesOrderID

--	update order if item BV is different
	IF @BV <> @BVItems
	BEGIN
		UPDATE SalesOrder SET BV = @BVItems WHERE SalesOrderID = @SalesOrderID
		SET @BV = @BVItems
	END

--	update member BV and QV
	UPDATE Member SET BV = BV + @BV, QV = QV + @BV WHERE MemberID = @MemberID

--	walk up the sponsor line and increment their Member group points (QV)
	SET @IDS = ','
	SET @SponsorID = 1
	WHILE @SponsorID != 0
	BEGIN
		SELECT @SponsorID = ISNULL(SponsorID,0) FROM Member Where MemberID = @MemberID
		IF @SponsorID != 0
		BEGIN
--			check if we already processed this SponsorID (stuck in a loop)
			SET @IDSTR = CAST(@SponsorID AS VARCHAR(10))
			IF CHARINDEX( ',' + @IDSTR + ',', @IDS ) = 0
			BEGIN
				UPDATE Member SET QV = QV + @BV WHERE MemberID = @SponsorID
				SET @MemberID = @SponsorID
				IF LEN( @IDS + @IDSTR + ',' ) < 8000
					SET @IDS = @IDS + @IDSTR + ','
				ELSE
					SET @SponsorID = 0
			END
			ELSE
			BEGIN
				SET @SponsorID = 0
			END
		END
	END
END

----------------------------------------------------------------------------------------------------------
-- recaclulate order BV only 
----------------------------------------------------------------------------------------------------------
IF @Status = 2
BEGIN 
--	get total BV from order items
	SELECT @BVItems = SUM(BV*Quantity) FROM SalesItem WHERE SalesOrderID = @SalesOrderID

--	get the member and BV for this order
	SELECT @BV = BV FROM SalesOrder WHERE SalesOrderID = @SalesOrderID

--	update order if item BV is different
	IF @BV <> @BVItems
	BEGIN
		UPDATE SalesOrder SET BV = @BVItems WHERE SalesOrderID = @SalesOrderID
	END

END



GO