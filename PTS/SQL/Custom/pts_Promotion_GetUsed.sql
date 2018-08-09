EXEC [dbo].pts_CheckProc 'pts_Promotion_GetUsed'
GO

CREATE PROCEDURE [dbo].pts_Promotion_GetUsed
   @PromotionID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

-- Get number of times the promotion has been used on sales orders that are submitted, inprocess or complete
SELECT @Result = COUNT(*) FROM SalesOrder WHERE PromotionID = @PromotionID AND Status >= 1 AND Status <= 3 

-- Save promotion usage count
UPDATE Promotion SET Used = @Result WHERE PromotionID = @PromotionID

GO
