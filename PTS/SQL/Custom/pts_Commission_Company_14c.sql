EXEC [dbo].pts_CheckProc 'pts_Commission_Company_14c'
GO
--DECLARE @Count int EXEC pts_Commission_Company_14c 7995, 0, '', @Count OUTPUT PRINT @Count
--select * from Commission order by CommissionID desc

--DECLARE @Count int EXEC pts_Commission_Company_14c 12922, 34149, '12922 Jane Wangeci Kinyanjui', '125', @Count output print @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_14c
   @MemberID int ,
   @PaymentID int ,
   @Ref varchar(100),
   @Code varchar(10),
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime 
DECLARE @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @SponsorID int
DECLARE @Team int, @Line int

IF @Ref = '' SELECT @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID
-- If missing PaymentID get the latest payment
IF @PaymentID = 0
BEGIN
	SELECT TOP 1 @PaymentID = PaymentID FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	WHERE so.MemberID = @MemberID ORDER BY pa.PayDate DESC
END

SET @CompanyID = 14
SET @Now = GETDATE()
SET @Count = 0

-- ***************************************************
-- Process Coded Bonuses
-- ***************************************************
SET @Team = 6
WHILE @Team <= 12
BEGIN
	IF @Team <= 10 SET @Line = @Team ELSE SET @Line = 10 
	SET @SponsorID = 0
	SELECT @SponsorID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @MemberID
	IF @SponsorID > 0
	BEGIN
		SET @Bonus = 0
		IF @Code = '104'  -- New Silver
		BEGIN
			IF @Team = 6 SET @Bonus = 1
			IF @Team = 7 SET @Bonus = 1
			IF @Team = 8 SET @Bonus = 1
			IF @Team = 9 SET @Bonus = 1
			IF @Team = 10 SET @Bonus = 1
			IF @Team = 11 SET @Bonus = 1
			IF @Team = 12 SET @Bonus = 1
		END
		IF @Code = '105'  -- New Gold
		BEGIN
			IF @Team = 6 SET @Bonus = 5
			IF @Team = 7 SET @Bonus = 2
			IF @Team = 8 SET @Bonus = 2
			IF @Team = 9 SET @Bonus = 2
			IF @Team = 10 SET @Bonus = 2
			IF @Team = 11 SET @Bonus = 1
			IF @Team = 12 SET @Bonus = 1
		END
		IF @Code = '106' OR @Code = '107' OR @Code = '108'  -- New Diamonds
		BEGIN
			IF @Team = 6 SET @Bonus = 15
			IF @Team = 7 SET @Bonus = 8
			IF @Team = 8 SET @Bonus = 7
			IF @Team = 9 SET @Bonus = 6
			IF @Team = 10 SET @Bonus = 5
			IF @Team = 11 SET @Bonus = 2
			IF @Team = 12 SET @Bonus = 2
		END
		IF @Code = '109' OR @Code = '110' OR @Code = '125' OR @Code = '101' OR @Code = '100'  -- New Diamonds
		BEGIN
			IF @Team = 6 SET @Bonus = 25
			IF @Team = 7 SET @Bonus = 10
			IF @Team = 8 SET @Bonus = 10
			IF @Team = 9 SET @Bonus = 10
			IF @Team = 10 SET @Bonus = 10
			IF @Team = 11 SET @Bonus = 10
			IF @Team = 12 SET @Bonus = 2
		END
		IF @Code = '131'  -- Upgrade Diamond
		BEGIN
			IF @Team = 6 SET @Bonus = 10
			IF @Team = 7 SET @Bonus = 5
			IF @Team = 8 SET @Bonus = 4
			IF @Team = 9 SET @Bonus = 3
			IF @Team = 10 SET @Bonus = 2
			IF @Team = 11 SET @Bonus = 1
			IF @Team = 12 SET @Bonus = 1
		END

		SELECT @Qualify = Qualify FROM Member WHERE MemberID = @SponsorID
		
		IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @SponsorID

		IF @Qualify > 1
		BEGIN
			IF @Bonus > 0
			BEGIN
				SET @CommType = 5
				SET @Desc = @Ref + ' (' + CAST(@Team AS VARCHAR(2)) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
--print @Desc
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
			END
			
--			-- Process PA1 and PA2 for upline Coded PAs
			IF @Team >= 10 SET @MemberID = @SponsorID 
		END	
	END
	SET @Team = @Team + 1
END

GO
