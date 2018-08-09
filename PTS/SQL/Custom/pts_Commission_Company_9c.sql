EXEC [dbo].pts_CheckProc 'pts_Commission_Company_9c'
GO
--DECLARE @Count int EXEC pts_Commission_Company_9c 7995, 0, '', @Count OUTPUT PRINT @Count
--select * from Commission order by CommissionID desc

--DECLARE @Count int EXEC pts_Commission_Company_9c 8911, 22695, '8911 Kayvon Allen', @Count output

CREATE PROCEDURE [dbo].pts_Commission_Company_9c
   @MemberID int ,
   @PaymentID int ,
   @Ref varchar(100),
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

SET @CompanyID = 9
SET @Now = GETDATE()

-- ***************************************************
-- Process Coded Bonuses
-- ***************************************************
SET @Team = 7
WHILE @Team <= 13
BEGIN
	IF @Team <= 11 SET @Line = @Team ELSE SET @Line = 11 
	SET @SponsorID = 0
	SELECT @SponsorID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @MemberID
	IF @SponsorID > 0
	BEGIN
		SELECT @Qualify = Qualify FROM Member WHERE MemberID = @SponsorID

		IF @Qualify > 1
		BEGIN
			SET @CommType = 9
			IF @Team = 7 SET @Bonus = 21
			IF @Team = 8 SET @Bonus = 6
			IF @Team = 9 SET @Bonus = 5
			IF @Team = 10 SET @Bonus = 4
			IF @Team = 11 SET @Bonus = 3
			IF @Team = 12 SET @Bonus = 2
			IF @Team = 13 SET @Bonus = 2
			SET @Desc = @Ref + ' (' + CAST(@Team AS VARCHAR(2)) + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
			
--			-- Process PA1 and PA2 for upline Coded PAs
			IF @Team >= 11 SET @MemberID = @SponsorID 
		END	
	END
	SET @Team = @Team + 1
END

GO
