EXEC [dbo].pts_CheckProc 'pts_Promo_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Promo_Delete ( 
   @PromoID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE prm
FROM Promo AS prm
WHERE prm.PromoID = @PromoID

GO