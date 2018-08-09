EXEC [dbo].pts_CheckProc 'pts_Guest_Delete'
GO

CREATE PROCEDURE [dbo].pts_Guest_Delete
   @GuestID int ,
   @UserID int
AS

DECLARE @mAuthUserID int, 
         @mPartyID int

SET NOCOUNT ON

EXEC pts_Guest_FetchPartyID
   @GuestID ,
   @UserID ,
   @mPartyID OUTPUT

DELETE gu
FROM Guest AS gu
WHERE (gu.GuestID = @GuestID)


EXEC pts_Party_CalcSales
   @mPartyID

GO