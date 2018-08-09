EXEC [dbo].pts_CheckProc 'pts_Party_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Party_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      py.PartyID, 
         ap.ApptName AS 'PartyName', 
         LTRIM(RTRIM(py.NameFirst)) +  ' '  + LTRIM(RTRIM(py.NameLast)) AS 'HostName', 
         ap.StartDate AS 'StartDate', 
         ap.StartTime AS 'StartTime', 
         py.Sales
FROM Party AS py (NOLOCK)
LEFT OUTER JOIN Appt AS ap (NOLOCK) ON (py.ApptID = ap.ApptID)
LEFT OUTER JOIN Calendar AS ca (NOLOCK) ON (ap.CalendarID = ca.CalendarID)
WHERE (ca.MemberID = @MemberID)

ORDER BY   ap.StartDate DESC

GO