EXEC [dbo].pts_CheckProc 'pts_Meeting_ListSeminar'
GO

CREATE PROCEDURE [dbo].pts_Meeting_ListSeminar
   @SeminarID int
AS

SET NOCOUNT ON

SELECT      mtg.MeetingID, 
         mtg.MeetingDate, 
         mtg.StartTime, 
         mtg.EndTime, 
         mtg.Status, 
         mtg.Limit, 
         mtg.Guests, 
         mtg.VenueName
FROM Meeting AS mtg (NOLOCK)
WHERE (mtg.SeminarID = @SeminarID)


GO