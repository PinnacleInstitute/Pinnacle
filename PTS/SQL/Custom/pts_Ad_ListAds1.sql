EXEC [dbo].pts_CheckProc 'pts_Ad_ListAds1'
GO

--EXEC pts_Ad_ListAds1 12, 1, 0, 1, 123
--select * from Ad

CREATE PROCEDURE [dbo].pts_Ad_ListAds1
   @CompanyID int ,
   @Placement int ,
   @RefID int ,
   @UType int ,
   @UID int 
AS

SET NOCOUNT ON
DECLARE @Now datetime, @AdID int, @AdTrackID int, @Msg nvarchar (2000)
SET @Now = GETDATE()

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
	SELECT TOP 9 adv.AdID, adv.Msg FROM Ad as adv
	WHERE CompanyID = @CompanyID AND Status = 2 
	AND ( StartDate = 0 OR StartDate <= @Now ) AND ( EndDate = 0 OR EndDate >= @Now )
	ORDER BY StartDate

	OPEN Ad_cursor
	FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC pts_AdTrack_Add @AdTrackID OUTPUT, @AdID, @Placement, @RefID, @UType, @UID, @Now, 0, 0
		INSERT INTO @Ads (AdID, AdTrackID, Msg ) VALUES ( @AdID, @AdTrackID, @Msg )
		FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg
	END
	CLOSE Ad_cursor
	DEALLOCATE Ad_cursor
END 

-- Category Page
IF @Placement = 2
BEGIN
	DECLARE Ad_cursor CURSOR LOCAL STATIC FOR 
	SELECT TOP 6 adv.AdID, adv.Msg FROM Ad as adv
	WHERE CompanyID = @CompanyID AND Status = 2 
	AND ( StartDate = 0 OR StartDate <= @Now ) AND ( EndDate = 0 OR EndDate >= @Now )
	ORDER BY StartDate

	OPEN Ad_cursor
	FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC pts_AdTrack_Add @AdTrackID OUTPUT, @AdID, @Placement, @RefID, @UType, @UID, @Now, 0, 0
		INSERT INTO @Ads (AdID, AdTrackID, Msg ) VALUES ( @AdID, @AdTrackID, @Msg )
		FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg
	END
	CLOSE Ad_cursor
	DEALLOCATE Ad_cursor
END 

-- Story, Search Page
IF @Placement > 2
BEGIN
	DECLARE Ad_cursor CURSOR LOCAL STATIC FOR 
	SELECT TOP 10 adv.AdID, adv.Msg FROM Ad as adv
	WHERE CompanyID = @CompanyID AND Status = 2 
	AND ( StartDate = 0 OR StartDate <= @Now ) AND ( EndDate = 0 OR EndDate >= @Now )
	ORDER BY StartDate

	OPEN Ad_cursor
	FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC pts_AdTrack_Add @AdTrackID OUTPUT, @AdID, @Placement, @RefID, @UType, @UID, @Now, 0, 0
		INSERT INTO @Ads (AdID, AdTrackID, Msg ) VALUES ( @AdID, @AdTrackID, @Msg )
		FETCH NEXT FROM Ad_cursor INTO @AdID, @Msg
	END
	CLOSE Ad_cursor
	DEALLOCATE Ad_cursor
END 

SELECT AdID, AdTrackID, Msg FROM @Ads

GO