EXEC [dbo].pts_CheckProc 'pts_Promotion_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Promotion_Delete ( 
   @PromotionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pm
FROM Promotion AS pm
WHERE pm.PromotionID = @PromotionID

GO