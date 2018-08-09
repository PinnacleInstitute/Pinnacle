EXEC [dbo].pts_CheckProc 'pts_Venue_Update'
 GO

CREATE PROCEDURE [dbo].pts_Venue_Update ( 
   @VenueID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ven
SET ven.SeminarID = @SeminarID ,
   ven.VenueName = @VenueName ,
   ven.Status = @Status ,
   ven.Street1 = @Street1 ,
   ven.Street2 = @Street2 ,
   ven.City = @City ,
   ven.State = @State ,
   ven.Zip = @Zip
FROM Venue AS ven
WHERE ven.VenueID = @VenueID

GO