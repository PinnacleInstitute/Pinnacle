EXEC [dbo].pts_CheckProc 'pts_Ad_ListAds'
GO

--EXEC pts_Ad_ListAds 12, 1, 0, 0, 0
--select * from Ad

CREATE PROCEDURE [dbo].pts_Ad_ListAds
   @CompanyID int ,
   @Placement int ,
   @RefID int ,
   @UType int ,
   @UID int 
AS

SET NOCOUNT ON
DECLARE @Now datetime, @AdID int, @AdTrackID int, @Msg nvarchar (2000), @Places int, @MaxPlace int, @cnt int
SET @Now = GETDATE()
SET @AdTrackID = 0

DECLARE @Ads TABLE(
   AdID int ,
   AdTrackID int ,
   Msg nvarchar (2000)
)

--	Process all Ads

-- Main Page
IF @Placement = 1
BEGIN
	DECLARE Ad_cursor CURSOR LOCAL STATIC FOR 
	WITH temp AS
	(SELECT *, ROW_NUMBER() OVER(PARTITION by Priority ORDER BY POrder) AS rowID
	FROM Ad
		WHERE CompanyID = @CompanyID AND Status = 2 
		AND ( StartDate = 0 OR StartDate <= @Now ) AND ( EndDate = 0 OR EndDate >= @Now )
		AND Placement < 4
	)
	SELECT TOP 9 AdID, Msg, MaxPlace, Places
	FROM temp
	WHERE rowID = 1
	ORDER BY Priority

	OPEN Ad_cursor
	FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg, @MaxPlace, @Places
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC pts_AdTrack_Add @AdTrackID OUTPUT, @AdID, @Placement, @RefID, @UType, @UID, @Now, 0, 0
		SET @Msg = REPLACE(@Msg,'{id}',CAST(@AdTrackID AS VARCHAR(10)))
		INSERT INTO @Ads (AdID, AdTrackID, Msg ) VALUES ( @AdID, @AdTrackID, @Msg )
		SET @Places = @Places + 1
		UPDATE Ad SET Places = @Places, POrder = POrder + 1 WHERE AdID = @AdID
		IF @MaxPlace > 0 AND @Places >= @MaxPlace UPDATE Ad SET Status = 3 WHERE AdID = @AdID
		FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg, @MaxPlace, @Places
	END
	CLOSE Ad_cursor
	DEALLOCATE Ad_cursor
END 

-- Category and Story Page
IF @Placement = 2
BEGIN
	DECLARE Ad_cursor CURSOR LOCAL STATIC FOR 
	WITH temp AS
	(SELECT *, ROW_NUMBER() OVER(PARTITION by Priority ORDER BY POrder) AS rowID
	FROM Ad
		WHERE CompanyID = @CompanyID AND Status = 2 
		AND ( StartDate = 0 OR StartDate <= @Now ) AND ( EndDate = 0 OR EndDate >= @Now )
		AND Placement < 4
	)
	SELECT TOP 6 AdID, Msg, MaxPlace, Places
	FROM temp
	WHERE rowID = 1
	ORDER BY Priority

	OPEN Ad_cursor
	FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg, @MaxPlace, @Places
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC pts_AdTrack_Add @AdTrackID OUTPUT, @AdID, @Placement, @RefID, @UType, @UID, @Now, 0, 0
		SET @Msg = REPLACE(@Msg,'{id}',CAST(@AdTrackID AS VARCHAR(10)))
		INSERT INTO @Ads (AdID, AdTrackID, Msg ) VALUES ( @AdID, @AdTrackID, @Msg )
		SET @Places = @Places + 1
		UPDATE Ad SET Places = @Places, POrder = POrder + 1 WHERE AdID = @AdID
		IF @MaxPlace > 0 AND @Places >= @MaxPlace UPDATE Ad SET Status = 3 WHERE AdID = @AdID
		FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg, @MaxPlace, @Places
	END
	CLOSE Ad_cursor
	DEALLOCATE Ad_cursor
END 

-- Email
IF @Placement = 4
BEGIN
	IF @RefID <= 3 SET @cnt = 3 ELSE SET @cnt = @RefID
	DECLARE Ad_cursor CURSOR LOCAL STATIC FOR 
	WITH temp AS
	(SELECT *, ROW_NUMBER() OVER(PARTITION by Priority ORDER BY POrder) AS rowID
	FROM Ad
		WHERE CompanyID = @CompanyID AND Status = 2 
		AND ( StartDate = 0 OR StartDate <= @Now ) AND ( EndDate = 0 OR EndDate >= @Now )
		AND Placement = 4
	)
	SELECT TOP 12 AdID, Msg, MaxPlace, Places
	FROM temp
	WHERE rowID = 1
	ORDER BY Priority

	OPEN Ad_cursor
	FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg, @MaxPlace, @Places
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @UID > 0
		BEGIN
			EXEC pts_AdTrack_Add @AdTrackID OUTPUT, @AdID, @Placement, @RefID, @UType, @UID, @Now, 0, 0
		END	
		SET @Msg = REPLACE(@Msg,'{id}',CAST(@AdTrackID AS VARCHAR(10)))
		INSERT INTO @Ads (AdID, AdTrackID, Msg ) VALUES ( @AdID, @AdTrackID, @Msg )
		IF @UID >= 0
		BEGIN
			SET @Places = @Places + 1
			UPDATE Ad SET Places = @Places, POrder = POrder + 1 WHERE AdID = @AdID
			IF @MaxPlace > 0 AND @Places >= @MaxPlace UPDATE Ad SET Status = 3 WHERE AdID = @AdID
		END
		
		SET @cnt = @cnt - 1
		IF @cnt > 0
			FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg, @MaxPlace, @Places
		ELSE
			BREAK	
	END
	CLOSE Ad_cursor
	DEALLOCATE Ad_cursor
END 

SELECT AdID, AdTrackID, Msg FROM @Ads

GO