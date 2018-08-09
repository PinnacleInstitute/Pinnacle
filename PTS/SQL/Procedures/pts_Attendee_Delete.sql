EXEC [dbo].pts_CheckProc 'pts_Attendee_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Attendee_Delete ( 
   @AttendeeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE atd
FROM Attendee AS atd
WHERE atd.AttendeeID = @AttendeeID

GO