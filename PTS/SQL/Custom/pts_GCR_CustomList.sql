EXEC [dbo].pts_CheckProc 'pts_GCR_CustomList'
GO

--EXEC pts_GCR_CustomList 11, 0, 0, 12046

CREATE PROCEDURE [dbo].pts_GCR_CustomList
   @Status int ,
   @czDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @StartDate datetime, @EndDate datetime, @Days int, @MiningDate datetime, @MemberID int
SET @CompanyID = 17

--Mining Pool History
IF @Status = 1
BEGIN
	SET @MemberID = @Amount
	SET @Days = (@Quantity * -1) + -1
	SET @EndDate = DATEADD(d,@Days, dbo.wtfn_DateOnly(GETDATE()))
--	Can't look back past 5/22/15
	IF @EndDate < '6/21/15' SET @EndDate = '6/21/15'
	SET @StartDate = DATEADD(d,-30,@EndDate)

	IF @MemberID = 0
	BEGIN
		SELECT rank() OVER (ORDER BY HASH, miningdate DESC) as GCRID, 
		  CASE Hash
			 WHEN 150 THEN 'Bronze'
			 WHEN 450 THEN 'Silver'
			 WHEN 1024 THEN 'Gold'
			 WHEN 2048 THEN 'Gold'
			 WHEN 3584 THEN 'Prospector'
			 WHEN 12288 THEN 'ClaimStaker'
			 ELSE ''
		  END + ' - ' + dbo.wtfn_DateOnlyStr(MiningDate) + ' - ' + CAST(coins as varchar(5)) + CASE WHEN Coins = 0 THEN '' ELSE     
		  ' - ' + '$' + CONVERT(VARCHAR(50), CONVERT(MONEY, COALESCE( ((
		  CASE Hash
			 WHEN 150 THEN 69.95
			 WHEN 450 THEN 149.95
			 WHEN 1024 THEN 299.95
			 WHEN 2048 THEN 599.95
			 WHEN 3584 THEN 999.95
			 WHEN 12288 THEN 2999.95
			 ELSE ''
		  END
		  /31) / coins), 0),1)) 
		  END 'Result'
		FROM (
		select MiningDate, Hash, AVG(coins)'coins' from mining where miningdate >= @StartDate and miningdate <= @EndDate AND HASH in (150,450,1024,3584,12288)
		group by Miningdate, HASH 
		) tmp
		order by HASH, miningdate DESC
	END
	ELSE
	BEGIN
		SELECT MiningID as GCRID, CAST(MemberID AS VARCHAR(10)) + ' - ' + dbo.wtfn_DateOnlyStr(MiningDate) + ' - ' + 
		CASE Hash
			WHEN 150 THEN 'Bronze'
			WHEN 450 THEN 'Silver'
			WHEN 1024 THEN 'Gold'
			WHEN 2048 THEN 'Gold'
			WHEN 3584 THEN 'Prospector'
			WHEN 12288 THEN 'ClaimStaker'
			ELSE ''
		END + ' - ' + CAST(Coins as varchar(5)) + CASE WHEN Coins = 0 THEN '' ELSE     
		' - ' + '$' + CONVERT(VARCHAR(50), CONVERT(MONEY, COALESCE( ((
		CASE Hash
			WHEN 150 THEN 69.95
			WHEN 450 THEN 149.95
			WHEN 1024 THEN 299.95
			WHEN 2048 THEN 599.95
			WHEN 3584 THEN 999.95
			WHEN 12288 THEN 2999.95
			ELSE ''
		END
		/31) / coins), 0),1)) 
		END 'Result'		
		FROM Mining WHERE MemberID = @MemberID AND MiningDate >= @StartDate and MiningDate <= @EndDate
		Order By MiningDate DESC
	END
END

--Mining Pool Daily Credits
IF @Status = 2
BEGIN
	SET @MiningDate = DATEADD(d,-1, dbo.wtfn_DateOnly(GETDATE()))
	EXEC pts_GCR_PoolCoin @MiningDate
	SELECT mi.MiningID 'GCRID', me.Email + '|' + CAST(mi.Coins AS VARCHAR(10)) 'Result' FROM Mining AS mi JOIN Member as me on mi.MemberID = me.MemberID where MiningDate = @MiningDate AND mi.Status = 0
END

--Member GCR Coin Orders summarized by date
IF @Status = 10
BEGIN
	SELECT CAST(PaidDate AS Int) 'GCRID', dbo.wtfn_DateOnlyStr(PaidDate) + ' - ' + 	CAST(Cnt AS VARCHAR(10)) + ' - ' + 	CAST(CONVERT(MONEY,Amount) AS VARCHAR(15)) 'Result'
	FROM (
		SELECT PaidDate, COUNT(*) 'Cnt', SUM(
		CASE 
			WHEN Purpose IN ( '104', '204' ) THEN Amount - 69.95
			WHEN Purpose IN ( '105', '205' ) THEN Amount - 274.95
			ELSE Amount
		END) 'Amount'
		FROM Payment
		WHERE CompanyID = 17 AND Status = 3
		AND Token = 0 AND PaidDate >= '11/6/15'
		AND ( ( Purpose IN ( '104', '204' ) AND Amount > 69.95  )
		OR 	( Purpose IN ( '105', '205' ) ) 
		OR 	( Purpose = 'GCRCOIN' ) )
		GROUP BY PaidDate	
	) AS tmp
	ORDER BY PaidDate
END

--Member GCR Coin Orders Details
IF @Status = 11
BEGIN
	SELECT pa.PaymentID 'GCRID',
	dbo.wtfn_DateOnlyStr(pa.PaidDate) + ' - ' + CAST(pa.PayType AS VARCHAR(15)) + ' - ' + 
	CAST(CONVERT(MONEY,
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN pa.Amount - 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN pa.Amount - 274.95
		ELSE pa.Amount
	END) AS VARCHAR(15)) + ' - ' + pa.purpose + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + 
	me.namefirst + ' ' + me.namelast
	 'Result'
	FROM Payment AS pa
	JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
	WHERE pa.CompanyID = 17 AND pa.Status = 3
	AND pa.Token = 0 AND pa.PaidDate >= '11/6/15'
		AND ( ( Purpose IN ( '104', '204' ) AND Amount > 69.95  )
		OR 	( Purpose IN ( '105', '205' ) ) 
		OR 	( Purpose = 'GCRCOIN' ) )
	ORDER BY pa.PaidDate, pa.paymentid 
END

--Member GCR Hardware Wallet Orders summarized by date
IF @Status = 12
BEGIN
	SELECT CAST(PaidDate AS Int) 'GCRID', dbo.wtfn_DateOnlyStr(PaidDate) + ' - ' + 	CAST(Cnt AS VARCHAR(10)) + ' - ' + 	CAST(CONVERT(MONEY,Amount) AS VARCHAR(15)) 'Result'
	FROM (
		SELECT PaidDate, COUNT(*) 'Cnt', SUM(Amount) 'Amount'
		FROM Payment
		WHERE CompanyID = 17 AND Status = 3
		AND Token != 2 AND PaidDate >= '11/6/15'
		AND Purpose IN ( '105', '205' ) 
		GROUP BY PaidDate	
	) AS tmp
	ORDER BY PaidDate
END

--Member GCR Hardware Wallet Orders Details
IF @Status = 13
BEGIN
	SELECT pa.PaymentID 'GCRID',
	dbo.wtfn_DateOnlyStr(pa.PaidDate) + ' - ' + CAST(pa.PayType AS VARCHAR(15)) + ' - ' + 
	CAST(CONVERT(MONEY, pa.Amount ) AS VARCHAR(15)) + ' - ' + pa.purpose + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + 
	me.namefirst + ' ' + me.namelast
	 'Result'
	FROM Payment AS pa
	JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
	WHERE pa.CompanyID = 17 AND pa.Status = 3
	AND pa.Token != 2 AND pa.PaidDate >= '11/6/15'
	AND pa.Purpose IN ( '105', '205' ) 
	ORDER BY pa.PaidDate, pa.paymentid 
END

GO

