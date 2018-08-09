EXEC [dbo].pts_CheckProc 'pts_Venue_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Venue_Delete ( 
   @VenueID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ven
FROM Venue AS ven
WHERE ven.VenueID = @VenueID

GO