EXEC [dbo].pts_CheckProc 'pts_Meeting_Update'
 GO

CREATE PROCEDURE [dbo].pts_Meeting_Update ( 
   @MeetingID int,
   @VenueID int,
   @MeetingDate datetime,
   @StartTime nvarchar (10),
   @EndTime nvarchar (10),
   @Status int,
   @Limit int,
   @Guests int,
   @Attended int,
   @Notes nvarchar (500),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mtg
SET mtg.VenueID = @VenueID ,
   mtg.MeetingDate = @MeetingDate ,
   mtg.StartTime = @StartTime ,
   mtg.EndTime = @EndTime ,
   mtg.Status = @Status ,
   mtg.Limit = @Limit ,
   mtg.Guests = @Guests ,
   mtg.Attended = @Attended ,
   mtg.Notes = @Notes
FROM Meeting AS mtg
WHERE mtg.MeetingID = @MeetingID

GO