EXEC [dbo].pts_CheckProc 'pts_Trainer_LoadAuthUser'
GO

CREATE PROCEDURE [dbo].pts_Trainer_LoadAuthUser
   @AuthUserID int ,
   @TrainerID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @TrainerID = tr.TrainerID
FROM Trainer AS tr (NOLOCK)
WHERE (tr.AuthUserID = @AuthUserID)


GO