EXEC [dbo].pts_CheckProc 'pts_Meeting_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Meeting_Fetch ( 
   @MeetingID int,
   @VenueID int OUTPUT,
   @MeetingDate datetime OUTPUT,
   @StartTime nvarchar (10) OUTPUT,
   @EndTime nvarchar (10) OUTPUT,
   @Status int OUTPUT,
   @Limit int OUTPUT,
   @Guests int OUTPUT,
   @Attended int OUTPUT,
   @Notes nvarchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @VenueID = mtg.VenueID ,
   @MeetingDate = mtg.MeetingDate ,
   @StartTime = mtg.StartTime ,
   @EndTime = mtg.EndTime ,
   @Status = mtg.Status ,
   @Limit = mtg.Limit ,
   @Guests = mtg.Guests ,
   @Attended = mtg.Attended ,
   @Notes = mtg.Notes
FROM Meeting AS mtg (NOLOCK)
WHERE mtg.MeetingID = @MeetingID

GO