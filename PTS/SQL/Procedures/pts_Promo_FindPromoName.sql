EXEC [dbo].pts_CheckProc 'pts_Promo_FindPromoName'
 GO

CREATE PROCEDURE [dbo].pts_Promo_FindPromoName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @MerchantID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(prm.PromoName, '') + dbo.wtfn_FormatNumber(prm.PromoID, 10) 'BookMark' ,
            prm.PromoID 'PromoID' ,
            prm.MerchantID 'MerchantID' ,
            prm.CountryID 'CountryID' ,
            prm.PromoName 'PromoName' ,
            prm.FromEmail 'FromEmail' ,
            prm.Subject 'Subject' ,
            prm.Message 'Message' ,
            prm.Status 'Status' ,
            prm.TargetArea 'TargetArea' ,
            prm.TargetType 'TargetType' ,
            prm.TargetDays 'TargetDays' ,
            prm.Target 'Target' ,
            prm.StartDate 'StartDate' ,
            prm.EndDate 'EndDate' ,
            prm.SendDate 'SendDate' ,
            prm.Msgs 'Msgs' ,
            prm.TestEmail 'TestEmail'
FROM Promo AS prm (NOLOCK)
WHERE ISNULL(prm.PromoName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(prm.PromoName, '') + dbo.wtfn_FormatNumber(prm.PromoID, 10) >= @BookMark
AND         (prm.MerchantID = @MerchantID)
ORDER BY 'Bookmark'

GO