EXEC [dbo].pts_CheckProc 'pts_Commission_Company_20c'
GO
--DECLARE @Count int EXEC pts_Commission_Company_20c 7995, 0, '', @Count OUTPUT PRINT @Count
--select * from Commission order by CommissionID desc

--DECLARE @Count int EXEC pts_Commission_Company_20c 12922, 34209, '12922 Jane Wangeci Kinyanjui', '125', @Count output print @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_20c
   @MemberID int ,
   @PaymentID int ,
   @Amount money,
   @Ref varchar(100),
   @Count int OUTPUT 
AS

DECLARE @CompanyID int, @ID int, @Now datetime 
DECLARE @Bonus money, @Desc varchar(100), @CommType int, @Qualify int, @SponsorID int
DECLARE @Team int, @Line int, @Title int

IF @Ref = '' SELECT @Ref = LTRIM(STR(MemberID)) + ' ' + NameFirst + ' ' + NameLast FROM Member WHERE MemberID = @MemberID
-- If missing PaymentID get the latest payment
IF @PaymentID = 0
BEGIN
	SELECT TOP 1 @PaymentID = PaymentID FROM Payment AS pa JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	WHERE so.MemberID = @MemberID ORDER BY pa.PayDate DESC
END

SET @CompanyID = 20
SET @Now = GETDATE()
SET @Count = 0

-- ***************************************************
-- Calculate Leadership Coded Bonuses
-- ***************************************************
SET @CommType = 2
SET @Bonus = ROUND(@Amount * .05, 2)

SET @Team = 2
WHILE @Team <= 4
BEGIN
	SET @SponsorID = 0
	SELECT @SponsorID = ParentID FROM Downline WHERE Line = @Team AND ChildID = @MemberID
	IF @SponsorID > 0
	BEGIN
		SELECT @Qualify = Qualify, @Title = Title FROM Member WHERE MemberID = @SponsorID
		IF @Title < @Team SET @Qualify = 0

		IF @Qualify <= 1 UPDATE Member SET Retail = Retail + @Bonus WHERE MemberID = @MemberID
		
		IF @Qualify > 1
		BEGIN
			SET @Desc = @Ref + ' (' + CAST(@Team AS VARCHAR(2)) + ')'
--			-- CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
			EXEC pts_Commission_Add @ID, @CompanyID, 4, @SponsorID, 0, @PaymentID, @Now, 1, @CommType, @Bonus, @Bonus, 0, @Desc, '', 0, 1
			SET @Count = @Count + 1
		END	
	END
	SET @Team = @Team + 1
END

GO
