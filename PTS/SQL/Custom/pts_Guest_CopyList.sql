EXEC [dbo].pts_CheckProc 'pts_Guest_CopyList'
GO

CREATE PROCEDURE [dbo].pts_Guest_CopyList
   @Result int OUTPUT ,
   @PartyID int ,
   @GuestID int
AS

SET         NOCOUNT ON

DECLARE @ApptID int
SET @ApptID = @GuestID

INSERT INTO Guest ( PartyID, NameLast, NameFirst, Email, Status, Attend, Sale )
SELECT @PartyID, gu.NameLast, gu.NameFirst, gu.Email, 1, 0, 0  
FROM Guest AS gu
JOIN Party AS pa ON pa.PartyID = gu.PartyID
WHERE pa.ApptID = @ApptID

SET @Result = 1

GO

