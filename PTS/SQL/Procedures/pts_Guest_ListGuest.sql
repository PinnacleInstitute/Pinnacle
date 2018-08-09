EXEC [dbo].pts_CheckProc 'pts_Guest_ListGuest'
GO

CREATE PROCEDURE [dbo].pts_Guest_ListGuest
   @PartyID int
AS

SET NOCOUNT ON

SELECT      gu.GuestID, 
         LTRIM(RTRIM(gu.NameLast)) +  ', '  + LTRIM(RTRIM(gu.NameFirst)) +  ''  AS 'GuestName', 
         gu.Email, 
         gu.Status, 
         gu.Attend, 
         gu.Sale
FROM Guest AS gu (NOLOCK)
WHERE (gu.PartyID = @PartyID)

ORDER BY   'GuestName'

GO