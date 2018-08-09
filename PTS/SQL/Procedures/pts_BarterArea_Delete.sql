EXEC [dbo].pts_CheckProc 'pts_BarterArea_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BarterArea_Delete ( 
   @BarterAreaID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bar
FROM BarterArea AS bar
WHERE bar.BarterAreaID = @BarterAreaID

GO