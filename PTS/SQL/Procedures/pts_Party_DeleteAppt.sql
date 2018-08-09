EXEC [dbo].pts_CheckProc 'pts_Party_DeleteAppt'
GO

CREATE PROCEDURE [dbo].pts_Party_DeleteAppt
   @ApptID int
AS

SET NOCOUNT ON

DELETE py
FROM Party AS py
WHERE (py.ApptID = @ApptID)


GO