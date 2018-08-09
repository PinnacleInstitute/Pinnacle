EXEC [dbo].pts_CheckProc 'pts_DripPage_Delete'
 GO

CREATE PROCEDURE [dbo].pts_DripPage_Delete ( 
   @DripPageID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE dep
FROM DripPage AS dep
WHERE dep.DripPageID = @DripPageID

GO