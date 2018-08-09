EXEC [dbo].pts_CheckProc 'pts_Mail_Move'
GO

CREATE PROCEDURE [dbo].pts_Mail_Move
   @OwnerType int ,
   @OwnerID int ,
   @MoveOwnerType int ,
   @MoveOwnerID int
AS

SET NOCOUNT ON

UPDATE MAIL 
SET OwnerType = @MoveOwnerType, OwnerID = @MoveOwnerID
WHERE OwnerType = @OwnerType AND OwnerID = @OwnerID

GO
