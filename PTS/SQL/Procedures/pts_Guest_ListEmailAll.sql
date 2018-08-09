EXEC [dbo].pts_CheckProc 'pts_Guest_ListEmailAll'
GO

CREATE PROCEDURE [dbo].pts_Guest_ListEmailAll
   @PartyID int
AS

SET NOCOUNT ON

SELECT      gu.GuestID, 
         gu.NameLast, 
         gu.NameFirst, 
         gu.Email
FROM Guest AS gu (NOLOCK)
WHERE (gu.PartyID = @PartyID)


GO