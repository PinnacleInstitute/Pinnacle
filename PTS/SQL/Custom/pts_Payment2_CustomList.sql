EXEC [dbo].pts_CheckProc 'pts_Payment2_CustomList'
GO

--EXEC pts_Payment2_CustomList 1, 0, 0, 0, 0, ''

CREATE PROCEDURE [dbo].pts_Payment2_CustomList
   @Status int ,
   @MerchantID int ,
   @PayType int ,
   @Amount money ,
   @PayDate datetime ,
   @Description nvarchar (100)
AS

SET NOCOUNT ON

-- Get all approved cryptocurrency payments that have not sent coins back to the merchant
IF @Status = 1
BEGIN
SELECT   pa2.Payment2ID, 
         '' AS 'ConsumerName', 
         '' AS 'StaffName', 
         '' AS 'AwardName', 
         pa2.PayDate, 
         pa2.PayType, 
         pa2.Status, 
         pa2.Total, 
         pa2.Amount, 
         pa2.Merchant, 
         pa2.Cashback, 
         pa2.Fee
FROM Payment2 AS pa2
WHERE PayType > 2 AND Status = 3 AND CoinStatus <> 2         

END
GO
