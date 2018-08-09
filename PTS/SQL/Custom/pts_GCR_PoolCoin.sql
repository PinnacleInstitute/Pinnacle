EXEC [dbo].pts_CheckProc 'pts_GCR_PoolCoin'
GO
--EXEC pts_GCR_PoolCoin '7/10/15'
--update mining set status = 1 where miningdate = '7/10/15'
--select mi.miningdate, me.email, mi.coins from mining as mi join Member as me on mi.memberid = me.memberid where miningdate = '7/10/15'

CREATE PROCEDURE [dbo].pts_GCR_PoolCoin
   @MiningDate datetime
AS

SET NOCOUNT ON

-- Mining.Status = -1 ... Old Mining estimated calculations
-- Mining.Status = 0  ... New Coins pending transfer
-- Mining.Status = 1  ... New Coins completed transfer

DECLARE @Result int, @MiningID int, @DailyHash int, @Hash int, @Coins int, @DailyCoins int, @Percent float

--If no date is specified, select yesterday
IF @MiningDate = 0 SET @MiningDate = DATEADD(d,-1,dbo.wtfn_DateOnly(GETDATE()))

--EXEC pts_GCR_PoolDay @MiningDate, @Result OUTPUT

--IF @Result = 1
-- The Last day for new mining orders was 11/18/15
IF @MiningDate < '11/19/15'
BEGIN
	SELECT @DailyCoins = Coins FROM MiningDay WHERE MiningDate = @MiningDate 

	IF @DailyCoins > 0
	BEGIN
		UPDATE Mining SET Coins = 0 WHERE MiningDate = @MiningDate

		SELECT @DailyHash = SUM(Hash) FROM Mining WHERE MiningDate = @MiningDate

		DECLARE Mining_cursor CURSOR LOCAL STATIC FOR 
		SELECT MiningID, Hash FROM Mining WHERE MiningDate = @MiningDate 

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
	END
END


GO

