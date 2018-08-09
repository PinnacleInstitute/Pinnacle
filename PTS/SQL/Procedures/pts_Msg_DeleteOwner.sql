EXEC [dbo].pts_CheckProc 'pts_Msg_DeleteOwner'
GO

CREATE PROCEDURE [dbo].pts_Msg_DeleteOwner
   @OwnerType int ,
   @OwnerID int ,
   @UserID int
AS

SET NOCOUNT ON

DELETE mg
FROM Msg AS mg
WHERE (mg.OwnerType = @OwnerType)
 AND (mg.OwnerID = @OwnerID)


GO