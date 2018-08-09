EXEC [dbo].pts_CheckProc 'pts_Meeting_Add'
 GO

CREATE PROCEDURE [dbo].pts_Meeting_Add ( 
   @MeetingID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Meeting (
            VenueID , 
            MeetingDate , 
            StartTime , 
            EndTime , 
            Status , 
            Limit , 
            Guests , 
            Attended , 
            Notes
            )
VALUES (
            @VenueID ,
            @MeetingDate ,
            @StartTime ,
            @EndTime ,
            @Status ,
            @Limit ,
            @Guests ,
            @Attended ,
            @Notes            )

SET @mNewID = @@IDENTITY

SET @MeetingID = @mNewID

GO