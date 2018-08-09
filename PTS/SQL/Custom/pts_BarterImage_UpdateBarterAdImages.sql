EXEC [dbo].pts_CheckProc 'pts_BarterImage_UpdateBarterAdImages'
GO

CREATE PROCEDURE [dbo].pts_BarterImage_UpdateBarterAdImages
   @BarterAdID int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON

UPDATE BarterAd 
SET Images = (SELECT COUNT(*) FROM BarterImage WHERE BarterAdID = @BarterAdID AND Status = 1)
WHERE BarterAdID = @BarterAdID

GO
