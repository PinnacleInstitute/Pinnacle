EXEC [dbo].pts_CheckProc 'pts_Payment2_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Payment2_Delete ( 
   @Payment2ID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pa2
FROM Payment2 AS pa2
WHERE pa2.Payment2ID = @Payment2ID

GO