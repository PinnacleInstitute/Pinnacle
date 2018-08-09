EXEC [dbo].pts_CheckProc 'pts_Debt_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Debt_Delete ( 
   @DebtID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE de
FROM Debt AS de
WHERE de.DebtID = @DebtID

GO