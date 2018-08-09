EXEC [dbo].pts_CheckProc 'pts_Guest_UpdateEmailStatus'
GO

CREATE PROCEDURE [dbo].pts_Guest_UpdateEmailStatus
   @Result int OUTPUT ,
   @PartyID int
AS

SET         NOCOUNT ON

UPDATE   gu
SET      gu.Status = 2 
FROM     Guest AS gu
WHERE    gu.PartyID = @PartyID
AND      gu.Status = 1

SET @Result = 1

GO
