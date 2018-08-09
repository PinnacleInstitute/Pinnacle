EXEC [dbo].pts_CheckProc 'pts_Nexxus_FastStart'
GO

-- EXEC pts_Nexxus_FastStart
--select Masterprice, Mastermembers, * FROM member where companyid = 21 and (masterprice > 0 or mastermembers > 0)
--select Masterprice, Mastermembers, * FROM member where memberid = 39032
--select Masterprice, Mastermembers, * FROM member where memberid = 39501
--select * from payment where ownerid = 39501

-- *******************************************************************
-- Calculate personal and 1st level fast start points
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_Nexxus_FastStart
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @MemberID int, @EnrollDate datetime, @Today datetime, @StartDate datetime, @EndDate datetime 
DECLARE @Sales money, @MaxSales money, @Points int, @cnt int

SET @CompanyID = 21
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @StartDate = DATEADD(day, -90, @Today)

-- Process all new members with the last 90 days OR If in first 90 days of promotion for all old members
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, dbo.wtfn_DateOnly(EnrollDate)
FROM Member WHERE CompanyID = @CompanyID AND ( EnrollDate >= @StartDate OR @Today < '7/30/16' )
--AND MemberID = 39501

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @MaxSales = 0
	SET @Points = 0
	SET @cnt = 0
	WHILE @cnt < 3
	BEGIN 
		SET @cnt = @cnt + 1

		IF @cnt = 1
		BEGIN
--			Get their 1st 30 day sales
			SET @StartDate = @EnrollDate
			IF @StartDate < '5/1/16' SET @StartDate = '5/1/16' -- all old members, start faststart program on 5/1/16
			SET @EndDate = DATEADD(day, 30, @StartDate)
			IF @EndDate > @Today SET @EndDate = @Today
		END
		IF @cnt > 1
		BEGIN
--			Get their 2nd 30 day sales
			SET @StartDate = DATEADD(day, 30, @EndDate)
			SET @EndDate = DATEADD(day, 30, @StartDate)
			IF @EndDate > @Today SET @EndDate = @Today
		END

		IF @StartDate > @Today
			SET @cnt = 3
		ELSE	
		BEGIN
--			Get their personal sales	
			SELECT @Sales = ISNULL( SUM( CASE Purpose
				 WHEN '101' THEN 10
				 WHEN '102' THEN 25
				 WHEN '103' THEN 50
				 WHEN '100' THEN 
					CASE PayType
						 WHEN 90 THEN Amount
						 ELSE Amount / 1.05 
					END
				 WHEN '999' THEN 2000
				 ELSE 0
			END ), 0)	
			FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND PaidDate >= @StartDate AND PaidDate < @EndDate

--			Get their customer sales	
			SELECT @Sales = @Sales + ISNULL( SUM( CASE Purpose
				 WHEN '200' THEN 2
				 WHEN '201' THEN 10
				 WHEN '202' THEN 10
				 WHEN '203' THEN 10
				 WHEN '204' THEN 25
				 WHEN '205' THEN 50
				 ELSE 0
			END ), 0)	
			FROM Payment as pa JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
			WHERE me.ReferralID = @MemberID AND pa.Status = 3 AND Amount > 0 AND pa.PaidDate >= @StartDate AND pa.PaidDate < @EndDate

			IF @Sales > @MaxSales SET @MaxSales = @Sales
		END
		IF @MaxSales >= 250 SET @Points = 1
		IF @MaxSales >= 500 SET @Points = 2
		IF @MaxSales >= 1000 SET @Points = 5
		IF @MaxSales >= 1500 SET @Points = 8
		IF @MaxSales >= 2000 SET @Points = 12
	END
	
	UPDATE Member SET MasterPrice = @Points WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

-- Update 1st level totals for enroller
SET @StartDate = DATEADD(day, -90, @Today)
UPDATE me SET MasterMembers = ( SELECT ISNULL(SUM(MasterPrice),0) FROM Member WHERE ReferralID = me.MemberID )
FROM Member AS me WHERE CompanyID = @CompanyID AND ( EnrollDate >= @StartDate OR @Today < '7/30/16' )

GO
