EXEC [dbo].pts_CheckProc 'pts_AdTrack_Add'
 GO

CREATE PROCEDURE [dbo].pts_AdTrack_Add ( 
   @AdTrackID int OUTPUT,
   @AdID int,
   @Place int,
   @RefID int,
   @UType int,
   @UID int,
   @PlaceDate datetime,
   @ClickDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO AdTrack (
            AdID , 
            Place , 
            RefID , 
            UType , 
            UID , 
            PlaceDate , 
            ClickDate
            )
VALUES (
            @AdID ,
            @Place ,
            @RefID ,
            @UType ,
            @UID ,
            @PlaceDate ,
            @ClickDate            )

SET @mNewID = @@IDENTITY

SET @AdTrackID = @mNewID

GO