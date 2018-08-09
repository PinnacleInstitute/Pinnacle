EXEC [dbo].pts_CheckProc 'pts_Trainer_Enum'
 GO

CREATE PROCEDURE [dbo].pts_Trainer_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         tr.TrainerID 'ID' ,
            tr.Email 'Name'
FROM Trainer AS tr (NOLOCK)
ORDER BY tr.Email

GO