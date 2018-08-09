EXEC [dbo].pts_CheckProc 'pts_Payment2_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Payment2_Fetch ( 
   @Payment2ID int,
   @MerchantID int OUTPUT,
   @ConsumerID int OUTPUT,
   @StaffID int OUTPUT,
   @AwardID int OUTPUT,
   @SalesOrderID int OUTPUT,
   @StatementID int OUTPUT,
   @MerchantName nvarchar (80) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @ConsumerName nvarchar (62) OUTPUT,
   @StaffName nvarchar (40) OUTPUT,
   @AwardName nvarchar (100) OUTPUT,
   @PayDate datetime OUTPUT,
   @PayType int OUTPUT,
   @Status int OUTPUT,
   @Total money OUTPUT,
   @Amount money OUTPUT,
   @Merchant money OUTPUT,
   @Cashback money OUTPUT,
   @Fee money OUTPUT,
   @PayCoins bigint OUTPUT,
   @PayRate money OUTPUT,
   @PaidCoins bigint OUTPUT,
   @Reference varchar (40) OUTPUT,
   @Description nvarchar (100) OUTPUT,
   @Notes varchar (500) OUTPUT,
   @Ticket int OUTPUT,
   @CommStatus int OUTPUT,
   @CommDate datetime OUTPUT,
   @CoinStatus int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MerchantID = pa2.MerchantID ,
   @ConsumerID = pa2.ConsumerID ,
   @StaffID = pa2.StaffID ,
   @AwardID = pa2.AwardID ,
   @SalesOrderID = pa2.SalesOrderID ,
   @StatementID = pa2.StatementID ,
   @MerchantName = mer.MerchantName ,
   @NameFirst = con.NameFirst ,
   @NameLast = con.NameLast ,
   @ConsumerName = LTRIM(RTRIM(con.NameFirst)) +  ' '  + LTRIM(RTRIM(con.NameLast)) ,
   @StaffName = sta.StaffName ,
   @AwardName = awd.Description ,
   @PayDate = pa2.PayDate ,
   @PayType = pa2.PayType ,
   @Status = pa2.Status ,
   @Total = pa2.Total ,
   @Amount = pa2.Amount ,
   @Merchant = pa2.Merchant ,
   @Cashback = pa2.Cashback ,
   @Fee = pa2.Fee ,
   @PayCoins = pa2.PayCoins ,
   @PayRate = pa2.PayRate ,
   @PaidCoins = pa2.PaidCoins ,
   @Reference = pa2.Reference ,
   @Description = pa2.Description ,
   @Notes = pa2.Notes ,
   @Ticket = pa2.Ticket ,
   @CommStatus = pa2.CommStatus ,
   @CommDate = pa2.CommDate ,
   @CoinStatus = pa2.CoinStatus
FROM Payment2 AS pa2 (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (pa2.MerchantID = mer.MerchantID)
LEFT OUTER JOIN Consumer AS con (NOLOCK) ON (pa2.ConsumerID = con.ConsumerID)
LEFT OUTER JOIN Staff AS sta (NOLOCK) ON (pa2.StaffID = sta.StaffID)
LEFT OUTER JOIN Award AS awd (NOLOCK) ON (pa2.AwardID = awd.AwardID)
WHERE pa2.Payment2ID = @Payment2ID

GO