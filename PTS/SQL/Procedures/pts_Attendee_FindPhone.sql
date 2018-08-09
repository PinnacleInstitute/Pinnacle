EXEC [dbo].pts_CheckProc 'pts_Attendee_FindPhone'
 GO

CREATE PROCEDURE [dbo].pts_Attendee_FindPhone ( 
   @SearchText nvarchar (30),
   @Bookmark nvarchar (40),
   @MaxRows tinyint OUTPUT,
   @SeminarID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(atd.Phone, '') + dbo.wtfn_FormatNumber(atd.AttendeeID, 10) 'BookMark' ,
            atd.AttendeeID 'AttendeeID' ,
            atd.SeminarID 'SeminarID' ,
            atd.MeetingID 'MeetingID' ,
            ven.VenueName 'VenueName' ,
            mtg.MeetingDate 'MeetingDate' ,
            mtg.StartTime 'StartTime' ,
            atd.NameFirst 'NameFirst' ,
            atd.NameLast 'NameLast' ,
            atd.Email 'Email' ,
            atd.Phone 'Phone' ,
            atd.Street1 'Street1' ,
            atd.Street2 'Street2' ,
            atd.City 'City' ,
            atd.State 'State' ,
            atd.Zip 'Zip' ,
            atd.Status 'Status' ,
            atd.Guests 'Guests' ,
            atd.IP 'IP' ,
            atd.RegisterDate 'RegisterDate' ,
            atd.Attended 'Attended' ,
            atd.Refer 'Refer'
FROM Attendee AS atd (NOLOCK)
LEFT OUTER JOIN Meeting AS mtg (NOLOCK) ON (atd.MeetingID = mtg.MeetingID)
LEFT OUTER JOIN Venue AS ven (NOLOCK) ON (mtg.VenueID = ven.VenueID)
WHERE ISNULL(atd.Phone, '') LIKE @SearchText + '%'
AND ISNULL(atd.Phone, '') + dbo.wtfn_FormatNumber(atd.AttendeeID, 10) >= @BookMark
AND         (atd.SeminarID = @SeminarID)
ORDER BY 'Bookmark'

GO