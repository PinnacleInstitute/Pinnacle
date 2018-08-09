EXEC [dbo].pts_CheckProc 'pts_Attendee_Report'
GO

CREATE PROCEDURE [dbo].pts_Attendee_Report
   @SeminarID int ,
   @ReportFromDate datetime ,
   @ReportToDate datetime ,
   @Result int OUTPUT
AS 

SET NOCOUNT ON
SET @Result = 0

SELECT @Result = COUNT(*) 
FROM Attendee AS atd
JOIN Meeting AS mtg ON atd.MeetingID = mtg.MeetingID
JOIN Venue AS ven ON mtg.VenueID = ven.VenueID
WHERE ven.SeminarID = @SeminarID
AND RegisterDate >= @ReportFromDate
AND RegisterDate < @ReportToDate

GO