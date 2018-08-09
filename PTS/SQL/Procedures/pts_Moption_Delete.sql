EXEC [dbo].pts_CheckProc 'pts_Moption_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Moption_Delete ( 
   @MoptionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mop
FROM Moption AS mop
WHERE mop.MoptionID = @MoptionID

GO