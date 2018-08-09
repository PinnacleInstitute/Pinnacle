EXEC [dbo].pts_CheckProc 'pts_Commission_Company_13c'
GO
--DECLARE @Count int EXEC pts_Commission_Company_13c 7995, 0, '', @Count OUTPUT PRINT @Count
--select * from Commission order by CommissionID desc

--DECLARE @Count int EXEC pts_Commission_Company_13c 8911, 22695, '8911 Kayvon Allen', @Count output

CREATE PROCEDURE [dbo].pts_Commission_Company_13c
   @MemberID int ,
   @PaymentID int ,
   @Ref varchar(100),
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime 
DECLARE @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @SponsorID int, @ReferralID int
DECLARE @Team int, @Line int 

IF @Ref = '' SELECT @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID
-- If missing PaymentID get the latest payment
IF @PaymentID = 0
BEGIN
	SELECT TOP 1 @PaymentID = PaymentID FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	WHERE so.MemberID = @MemberID ORDER BY pa.PayDate DESC
END

SET @CompanyID = 13
SET @Now = GETDATE()

-- ***************************************************
-- Process Coded Bonuses
-- ***************************************************
SET @Team = 5
WHILE @Team <= 11
BEGIN
--	Skip Team 8, no coded team for Blue Daimond
	IF @Team = 8 SET @Team = 9
	
	SET @SponsorID = 0
	SELECT @SponsorID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @MemberID
	IF @SponsorID > 0
	BEGIN
		SELECT @Qualify = Qualify, @ReferralID = ReferralID FROM Member WHERE MemberID = @SponsorID

		IF @Qualify > 1
		BEGIN
			SET @CommType = 3
			IF @Team = 5 SET @Bonus = 17
			IF @Team = 6 SET @Bonus = 5
			IF @Team = 7 SET @Bonus = 4
			IF @Team = 9 SET @Bonus = 3
			IF @Team = 10 SET @Bonus = 3
			IF @Team = 11 SET @Bonus = 3
			SET @Desc = @Ref + ' (' + CAST(@Team AS VARCHAR(2)) + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
			
--			******************************
--			Calculate Matching Bonus
--			******************************
			SELECT @Qualify = Qualify FROM Member WHERE MemberID = @ReferralID
			IF @Qualify > 1
			BEGIN
				SET @CommType = 6
				SET @Bonus = @Bonus * .2
				SET @Desc = @Ref + ' (' + CAST( @SponsorID AS VARCHAR(10) ) + ')'
--				-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
				EXEC pts_Commission_Add @ID, @CompanyID, 4, @ReferralID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
				SET @Count = @Count + 1
			END	
		END	
	END
	SET @Team = @Team + 1
END

GO
