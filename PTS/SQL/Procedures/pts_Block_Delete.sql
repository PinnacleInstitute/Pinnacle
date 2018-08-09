EXEC [dbo].pts_CheckProc 'pts_Block_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Block_Delete ( 
   @BlockID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE blo
FROM Block AS blo
WHERE blo.BlockID = @BlockID

GO