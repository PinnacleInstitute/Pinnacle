EXEC [dbo].pts_CheckProc 'pts_Attendee_List'
GO

CREATE PROCEDURE [dbo].pts_Attendee_List
   @MeetingID int
AS

SET NOCOUNT ON

SELECT      atd.AttendeeID, 
         atd.NameFirst, 
         atd.NameLast, 
         atd.Email, 
         atd.Phone, 
         atd.Street1, 
         atd.Street2, 
         atd.City, 
         atd.State, 
         atd.Zip, 
         atd.Status, 
         atd.Guests, 
         atd.IP, 
         atd.RegisterDate, 
         atd.Attended, 
         atd.Refer
FROM Attendee AS atd (NOLOCK)
WHERE (atd.MeetingID = @MeetingID)

ORDER BY   atd.NameLast , atd.NameFirst

GO