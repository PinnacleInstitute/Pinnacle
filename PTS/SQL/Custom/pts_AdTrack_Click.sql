EXEC [dbo].pts_CheckProc 'pts_AdTrack_Click'
GO

--EXEC pts_AdTrack_Click 100
--select * from adtrack where adtrackid = 100

CREATE PROCEDURE [dbo].pts_AdTrack_Click
   @AdTrackID int
AS

SET NOCOUNT ON
DECLARE @AdID int
SELECT @AdID = AdID FROM AdTrack WHERE AdTrackID = @AdTrackID
UPDATE AdTrack SET ClickDate = GETDATE() WHERE AdTrackID = @AdTrackID
UPDATE Ad SET Clicks = Clicks + 1 WHERE AdID = @AdID

GO