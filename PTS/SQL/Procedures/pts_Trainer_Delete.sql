EXEC [dbo].pts_CheckProc 'pts_Trainer_Delete'
GO

CREATE PROCEDURE [dbo].pts_Trainer_Delete
   @TrainerID int ,
   @UserID int
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   03 ,
   @TrainerID

EXEC pts_Trainer_FetchAuthUserID
   @TrainerID ,
   @UserID ,
   @mAuthUserID OUTPUT

EXEC pts_AuthUser_Delete
   @mAuthUserID ,
   @UserID

DELETE tr
FROM Trainer AS tr
WHERE (tr.TrainerID = @TrainerID)


GO