EXEC [dbo].pts_CheckProc 'pts_Venue_List'
GO

CREATE PROCEDURE [dbo].pts_Venue_List
   @SeminarID int
AS

SET NOCOUNT ON

SELECT      ven.VenueID, 
         ven.VenueName, 
         ven.Status, 
         ven.Street1, 
         ven.Street2, 
         ven.City, 
         ven.State, 
         ven.Zip
FROM Venue AS ven (NOLOCK)
WHERE (ven.SeminarID = @SeminarID)


GO