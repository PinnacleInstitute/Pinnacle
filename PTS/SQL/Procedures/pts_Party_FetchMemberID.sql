EXEC [dbo].pts_CheckProc 'pts_Party_FetchMemberID'
GO

CREATE PROCEDURE [dbo].pts_Party_FetchMemberID
   @PartyID int ,
   @MemberID int OUTPUT
AS

DECLARE @mMemberID int

SET NOCOUNT ON

SELECT      @mMemberID = ca.MemberID
FROM Party AS py (NOLOCK)
LEFT OUTER JOIN Appt AS ap (NOLOCK) ON (py.ApptID = ap.ApptID)
LEFT OUTER JOIN Calendar AS ca (NOLOCK) ON (ap.CalendarID = ca.CalendarID)
WHERE (py.PartyID = @PartyID)


SET @MemberID = ISNULL(@mMemberID, 0)
GO