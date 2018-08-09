EXEC [dbo].pts_CheckProc 'pts_Party_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Party_Delete ( 
   @PartyID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE py
FROM Party AS py
WHERE py.PartyID = @PartyID

GO