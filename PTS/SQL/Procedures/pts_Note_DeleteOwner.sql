EXEC [dbo].pts_CheckProc 'pts_Note_DeleteOwner'
GO

CREATE PROCEDURE [dbo].pts_Note_DeleteOwner
   @OwnerType int ,
   @OwnerID int ,
   @UserID int
AS

SET NOCOUNT ON

DELETE nt
FROM Note AS nt
WHERE (nt.OwnerType = @OwnerType)
 AND (nt.OwnerID = @OwnerID)


GO