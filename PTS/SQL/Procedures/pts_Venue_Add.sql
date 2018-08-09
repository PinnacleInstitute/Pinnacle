EXEC [dbo].pts_CheckProc 'pts_Venue_Add'
 GO

CREATE PROCEDURE [dbo].pts_Venue_Add ( 
   @VenueID int OUTPUT,
   @SeminarID int,
   @VenueName nvarchar (60),
   @Status int,
   @Street1 nvarchar (60),
   @Street2 nvarchar (60),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Venue (
            SeminarID , 
            VenueName , 
            Status , 
            Street1 , 
            Street2 , 
            City , 
            State , 
            Zip
            )
VALUES (
            @SeminarID ,
            @VenueName ,
            @Status ,
            @Street1 ,
            @Street2 ,
            @City ,
            @State ,
            @Zip            )

SET @mNewID = @@IDENTITY

SET @VenueID = @mNewID

GO