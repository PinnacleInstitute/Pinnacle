EXEC [dbo].pts_CheckProc 'pts_Bonus_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Bonus_Delete ( 
   @BonusID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bo
FROM Bonus AS bo
WHERE bo.BonusID = @BonusID

GO