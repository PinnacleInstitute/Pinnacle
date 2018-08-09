EXEC [dbo].pts_CheckProc 'pts_Payment2_FindConsumerStatusReference'
 GO

CREATE PROCEDURE [dbo].pts_Payment2_FindConsumerStatusReference ( 
   @SearchText varchar (40),
   @Bookmark varchar (50),
   @MaxRows tinyint OUTPUT,
   @ConsumerID int,
   @Status int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(pa2.Reference, '') + dbo.wtfn_FormatNumber(pa2.Payment2ID, 10) 'BookMark' ,
            pa2.Payment2ID 'Payment2ID' ,
            pa2.MerchantID 'MerchantID' ,
            pa2.ConsumerID 'ConsumerID' ,
            pa2.StaffID 'StaffID' ,
            pa2.AwardID 'AwardID' ,
            pa2.SalesOrderID 'SalesOrderID' ,
            pa2.StatementID 'StatementID' ,
            mer.MerchantName 'MerchantName' ,
            con.NameFirst 'NameFirst' ,
            con.NameLast 'NameLast' ,
            LTRIM(RTRIM(con.NameFirst)) +  ' '  + LTRIM(RTRIM(con.NameLast)) 'ConsumerName' ,
            sta.StaffName 'StaffName' ,
            awd.Description 'AwardName' ,
            pa2.PayDate 'PayDate' ,
            pa2.PayType 'PayType' ,
            pa2.Status 'Status' ,
            pa2.Total 'Total' ,
            pa2.Amount 'Amount' ,
            pa2.Merchant 'Merchant' ,
            pa2.Cashback 'Cashback' ,
            pa2.Fee 'Fee' ,
            pa2.PayCoins 'PayCoins' ,
            pa2.PayRate 'PayRate' ,
            pa2.PaidCoins 'PaidCoins' ,
            pa2.Reference 'Reference' ,
            pa2.Description 'Description' ,
            pa2.Notes 'Notes' ,
            pa2.Ticket 'Ticket' ,
            pa2.CommStatus 'CommStatus' ,
            pa2.CommDate 'CommDate' ,
            pa2.CoinStatus 'CoinStatus'
FROM Payment2 AS pa2 (NOLOCK)
LEFT OUTER JOIN Merchant AS mer (NOLOCK) ON (pa2.MerchantID = mer.MerchantID)
LEFT OUTER JOIN Consumer AS con (NOLOCK) ON (pa2.ConsumerID = con.ConsumerID)
LEFT OUTER JOIN Staff AS sta (NOLOCK) ON (pa2.StaffID = sta.StaffID)
LEFT OUTER JOIN Award AS awd (NOLOCK) ON (pa2.AwardID = awd.AwardID)
WHERE ISNULL(pa2.Reference, '') LIKE @SearchText + '%'
AND ISNULL(pa2.Reference, '') + dbo.wtfn_FormatNumber(pa2.Payment2ID, 10) >= @BookMark
AND         (pa2.ConsumerID = @ConsumerID)
AND         (pa2.Status = @Status)
ORDER BY 'Bookmark'

GO