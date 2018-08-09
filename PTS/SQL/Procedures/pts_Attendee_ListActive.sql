EXEC [dbo].pts_CheckProc 'pts_Attendee_ListActive'
GO

CREATE PROCEDURE [dbo].pts_Attendee_ListActive
   @MeetingID int
AS

SET NOCOUNT ON

SELECT      atd.AttendeeID, 
         atd.NameFirst, 
         atd.NameLast, 
         atd.Email
FROM Attendee AS atd (NOLOCK)
WHERE (atd.MeetingID = @MeetingID)
 AND (atd.Status = 1)


GO