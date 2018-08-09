-----------------------------
-- Create Mining Order Coins
-----------------------------
--select DATEDIFF(d,'7/1/14','4/25/15')
--select 298 * 60000

DECLARE @MiningID int, @DailyHash int, @Hash int, @Coins int, @tmpDate datetime, @StartDate datetime, @EndDate datetime, @DailyCoins int, @Percent float

SET @DailyCoins = 120000 
SET @StartDate = '7/1/14'
SET @EndDate = DATEADD(d,-1,dbo.wtfn_DateOnly(GETDATE()))

UPDATE Mining SET Coins = 0 WHERE MiningDate >= @StartDate AND MiningDate <= @EndDate 
--select * from mining where miningdate >= '6/1/15'

SET @tmpDate = @StartDate
WHILE @tmpDate <= @EndDate
BEGIN
	SELECT @DailyHash = SUM(Hash) FROM Mining WHERE MiningDate = @tmpDate 

--select sum(coins) from mining where memberid = 19469

	DECLARE Mining_cursor CURSOR LOCAL STATIC FOR 
	SELECT MiningID, Hash FROM Mining WHERE MiningDate = @tmpDate 
	OPEN Mining_cursor
	FETCH NEXT FROM Mining_cursor INTO @MiningID, @Hash
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Percent = CAST(@Hash AS float) / @DailyHash
		SET @Coins = @DailyCoins * @Percent

		UPDATE Mining SET Coins = @Coins WHERE MiningID = @MiningID
		FETCH NEXT FROM Mining_cursor INTO @MiningID, @Hash
	END
	CLOSE Mining_cursor
	DEALLOCATE Mining_cursor

	SET @tmpDate = DATEADD( d, 1, @tmpDate) 
END

GO

--	IF @Purpose IN ('103', '203' ) SET @Hash = 150
--	IF @Purpose IN ('104', '204' ) SET @Hash = 450
--	IF @Purpose IN ('105', '205' ) SET @Hash = 1024 -- 1M
--	IF @Purpose IN ('106', '206' ) SET @Hash = 2048 -- 3M
--	IF @Purpose IN ('107', '207' ) SET @Hash = 3584 -- 3.5M
--	IF @Purpose IN ('108', '208' ) SET @Hash = 12288 -- 12M

--SELECT miningdate, SUM(Hash) FROM Mining WHERE MiningDate >= '6/1/15'  group by miningdate order by miningdate
--SELECT * FROM Mining WHERE MiningDate = '6/1/15'

--select miningdate, AVG(coins) from mining where miningdate >= '6/1/15' and HASH = 150 group by miningdate order by miningdate
--select hash, MIN(Coins), Max(Coins), AVG(coins) from mining where miningdate >= '6/1/15' and miningdate <= '6/17/15' group by hash order by hash
--13,
-- 8,25,58,200,700 
--13,42,87,328,1173
--16,49,111,390,1339

--select sum(coins) from mining where MiningDate = '6/17/15'
--16,49,111,390,1339

--select * from mining where coins = 0
--select sum(coins) from mining where memberid = 17629
--select me.memberid, me.namefirst, me.namelast, sum(coins) 
--from mining as mi
--join Member as me on mi.memberid = me.memberid
--group by me.memberid, me.namefirst, me.namelast
--order by sum(coins) desc

--select * from mining where memberid = 12046 and coins > 0 order by miningdate desc
--update mining set coins = 0 where miningdate > '4/25/15'