EXEC [dbo].pts_CheckProc 'pts_Party_FetchPartyID'
GO

CREATE PROCEDURE [dbo].pts_Party_FetchPartyID
   @ApptID int ,
   @PartyID int OUTPUT
AS

DECLARE @mPartyID int

SET NOCOUNT ON

SELECT      @mPartyID = py.PartyID
FROM Party AS py (NOLOCK)
WHERE (py.ApptID = @ApptID)


SET @PartyID = ISNULL(@mPartyID, 0)
GO