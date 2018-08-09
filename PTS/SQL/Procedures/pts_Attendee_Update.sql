EXEC [dbo].pts_CheckProc 'pts_Attendee_Update'
 GO

CREATE PROCEDURE [dbo].pts_Attendee_Update ( 
   @AttendeeID int,
   @SeminarID int,
   @MeetingID int,
   @NameFirst nvarchar (30),
   @NameLast nvarchar (30),
   @Email nvarchar (80),
   @Phone nvarchar (30),
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Status int,
   @Guests int,
   @IP varchar (15),
   @RegisterDate datetime,
   @Attended int,
   @Refer nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE atd
SET atd.SeminarID = @SeminarID ,
   atd.MeetingID = @MeetingID ,
   atd.NameFirst = @NameFirst ,
   atd.NameLast = @NameLast ,
   atd.Email = @Email ,
   atd.Phone = @Phone ,
   atd.Street1 = @Street1 ,
   atd.Street2 = @Street2 ,
   atd.City = @City ,
   atd.State = @State ,
   atd.Zip = @Zip ,
   atd.Status = @Status ,
   atd.Guests = @Guests ,
   atd.IP = @IP ,
   atd.RegisterDate = @RegisterDate ,
   atd.Attended = @Attended ,
   atd.Refer = @Refer
FROM Attendee AS atd
WHERE atd.AttendeeID = @AttendeeID

GO