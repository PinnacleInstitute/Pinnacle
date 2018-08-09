EXEC [dbo].pts_CheckProc 'pts_Statement_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Statement_Delete ( 
   @StatementID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE stm
FROM Statement AS stm
WHERE stm.StatementID = @StatementID

GO