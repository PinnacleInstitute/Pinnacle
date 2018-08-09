EXEC [dbo].pts_CheckProc 'pts_Guest_FetchPartyID'
GO

CREATE PROCEDURE [dbo].pts_Guest_FetchPartyID
   @GuestID int ,
   @UserID int ,
   @PartyID int OUTPUT
AS

DECLARE @mPartyID int

SET NOCOUNT ON

SELECT      @mPartyID = gu.PartyID
FROM Guest AS gu (NOLOCK)
WHERE (gu.GuestID = @GuestID)


SET @PartyID = ISNULL(@mPartyID, 0)
GO