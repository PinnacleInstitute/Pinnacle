EXEC [dbo].pts_CheckProc 'pts_Meeting_List'
GO

CREATE PROCEDURE [dbo].pts_Meeting_List
   @VenueID int
AS

SET NOCOUNT ON

SELECT      mtg.MeetingID, 
         mtg.MeetingDate, 
         mtg.StartTime, 
         mtg.EndTime, 
         mtg.Status, 
         mtg.Limit, 
         mtg.Guests, 
         mtg.Attended, 
         mtg.Notes
FROM Meeting AS mtg (NOLOCK)
WHERE (mtg.VenueID = @VenueID)

ORDER BY   mtg.MeetingDate , mtg.StartTime

GO