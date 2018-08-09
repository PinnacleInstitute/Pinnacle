EXEC [dbo].pts_CheckProc 'pts_BinarySale_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BinarySale_Delete ( 
   @BinarySaleID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bs
FROM BinarySale AS bs
WHERE bs.BinarySaleID = @BinarySaleID

GO