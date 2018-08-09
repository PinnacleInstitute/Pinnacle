EXEC [dbo].pts_CheckProc 'pts_Venue_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Venue_Fetch ( 
   @VenueID int,
   @SeminarID int OUTPUT,
   @VenueName nvarchar (60) OUTPUT,
   @Status int OUTPUT,
   @Street1 nvarchar (60) OUTPUT,
   @Street2 nvarchar (60) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SeminarID = ven.SeminarID ,
   @VenueName = ven.VenueName ,
   @Status = ven.Status ,
   @Street1 = ven.Street1 ,
   @Street2 = ven.Street2 ,
   @City = ven.City ,
   @State = ven.State ,
   @Zip = ven.Zip
FROM Venue AS ven (NOLOCK)
WHERE ven.VenueID = @VenueID

GO