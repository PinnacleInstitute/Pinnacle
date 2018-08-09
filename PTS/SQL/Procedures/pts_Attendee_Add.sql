EXEC [dbo].pts_CheckProc 'pts_Attendee_Add'
 GO

CREATE PROCEDURE [dbo].pts_Attendee_Add ( 
   @AttendeeID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Attendee (
            SeminarID , 
            MeetingID , 
            NameFirst , 
            NameLast , 
            Email , 
            Phone , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip , 
            Status , 
            Guests , 
            IP , 
            RegisterDate , 
            Attended , 
            Refer
            )
VALUES (
            @SeminarID ,
            @MeetingID ,
            @NameFirst ,
            @NameLast ,
            @Email ,
            @Phone ,
            @Street1 ,
            @Street2 ,
            @City ,
            @State ,
            @Zip ,
            @Status ,
            @Guests ,
            @IP ,
            @RegisterDate ,
            @Attended ,
            @Refer            )

SET @mNewID = @@IDENTITY

SET @AttendeeID = @mNewID

GO