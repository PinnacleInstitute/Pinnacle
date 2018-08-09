EXEC [dbo].pts_CheckProc 'pts_Attendee_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Attendee_Fetch ( 
   @AttendeeID int,
   @SeminarID int OUTPUT,
   @MeetingID int OUTPUT,
   @VenueName nvarchar (60) OUTPUT,
   @MeetingDate datetime OUTPUT,
   @StartTime nvarchar (10) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Phone nvarchar (30) OUTPUT,
   @Street1 nvarchar (60) OUTPUT,
   @Street2 nvarchar (60) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Status int OUTPUT,
   @Guests int OUTPUT,
   @IP varchar (15) OUTPUT,
   @RegisterDate datetime OUTPUT,
   @Attended int OUTPUT,
   @Refer nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SeminarID = atd.SeminarID ,
   @MeetingID = atd.MeetingID ,
   @VenueName = ven.VenueName ,
   @MeetingDate = mtg.MeetingDate ,
   @StartTime = mtg.StartTime ,
   @NameFirst = atd.NameFirst ,
   @NameLast = atd.NameLast ,
   @Email = atd.Email ,
   @Phone = atd.Phone ,
   @Street1 = atd.Street1 ,
   @Street2 = atd.Street2 ,
   @City = atd.City ,
   @State = atd.State ,
   @Zip = atd.Zip ,
   @Status = atd.Status ,
   @Guests = atd.Guests ,
   @IP = atd.IP ,
   @RegisterDate = atd.RegisterDate ,
   @Attended = atd.Attended ,
   @Refer = atd.Refer
FROM Attendee AS atd (NOLOCK)
LEFT OUTER JOIN Meeting AS mtg (NOLOCK) ON (atd.MeetingID = mtg.MeetingID)
LEFT OUTER JOIN Venue AS ven (NOLOCK) ON (mtg.VenueID = ven.VenueID)
WHERE atd.AttendeeID = @AttendeeID

GO