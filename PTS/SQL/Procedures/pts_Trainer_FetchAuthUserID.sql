EXEC [dbo].pts_CheckProc 'pts_Trainer_FetchAuthUserID'
GO

CREATE PROCEDURE [dbo].pts_Trainer_FetchAuthUserID
   @TrainerID int ,
   @UserID int ,
   @AuthUserID int OUTPUT
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

SELECT      @mAuthUserID = tr.AuthUserID
FROM Trainer AS tr (NOLOCK)
WHERE (tr.TrainerID = @TrainerID)


SET @AuthUserID = ISNULL(@mAuthUserID, 0)
GO