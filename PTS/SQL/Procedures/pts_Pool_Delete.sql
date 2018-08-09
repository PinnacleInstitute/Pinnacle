EXEC [dbo].pts_CheckProc 'pts_Pool_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Pool_Delete ( 
   @PoolID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE poo
FROM Pool AS poo
WHERE poo.PoolID = @PoolID

GO