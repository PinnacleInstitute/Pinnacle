EXEC [dbo].pts_CheckProc 'pts_BarterImage_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BarterImage_Delete ( 
   @BarterImageID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bai
FROM BarterImage AS bai
WHERE bai.BarterImageID = @BarterImageID

GO