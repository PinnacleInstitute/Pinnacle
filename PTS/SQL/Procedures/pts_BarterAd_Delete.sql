EXEC [dbo].pts_CheckProc 'pts_BarterAd_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BarterAd_Delete ( 
   @BarterAdID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bad
FROM BarterAd AS bad
WHERE bad.BarterAdID = @BarterAdID

GO