EXEC [dbo].pts_CheckProc 'pts_Merchant_FindCity'
 GO

CREATE PROCEDURE [dbo].pts_Merchant_FindCity ( 
   @SearchText nvarchar (30),
   @Bookmark nvarchar (40),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(mer.City, '') + dbo.wtfn_FormatNumber(mer.MerchantID, 10) 'BookMark' ,
            mer.MerchantID 'MerchantID' ,
            mer.MemberID 'MemberID' ,
            mer.BillingID 'BillingID' ,
            mer.PayoutID 'PayoutID' ,
            mer.CountryID 'CountryID' ,
            mer.SweepID 'SweepID' ,
            me.NameLast 'MemberNameLast' ,
            me.NameFirst 'MemberNameFirst' ,
            LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) 'MemberName' ,
            cou.CountryName 'CountryName' ,
            mer.MerchantName 'MerchantName' ,
            mer.NameLast 'NameLast' ,
            mer.NameFirst 'NameFirst' ,
            mer.Email 'Email' ,
            mer.Email2 'Email2' ,
            mer.Email3 'Email3' ,
            mer.Phone 'Phone' ,
            mer.Phone2 'Phone2' ,
            mer.Password 'Password' ,
            mer.Password2 'Password2' ,
            mer.Password3 'Password3' ,
            mer.Password4 'Password4' ,
            mer.Status 'Status' ,
            mer.Street1 'Street1' ,
            mer.Street2 'Street2' ,
            mer.City 'City' ,
            mer.State 'State' ,
            mer.Zip 'Zip' ,
            mer.Referrals 'Referrals' ,
            mer.Referrals2 'Referrals2' ,
            mer.VisitDate 'VisitDate' ,
            mer.IsOrg 'IsOrg' ,
            mer.IsAwards 'IsAwards' ,
            mer.EnrollDate 'EnrollDate' ,
            mer.BillDate 'BillDate' ,
            mer.BillDays 'BillDays' ,
            mer.Image 'Image' ,
            mer.Description 'Description' ,
            mer.Terms 'Terms' ,
            mer.Options 'Options' ,
            mer.StoreOptions 'StoreOptions' ,
            mer.Colors 'Colors' ,
            mer.Rating 'Rating' ,
            mer.CurrencyCode 'CurrencyCode' ,
            mer.Processor 'Processor' ,
            mer.Payment 'Payment' ,
            mer.UserKey 'UserKey' ,
            mer.UserKey3 'UserKey3' ,
            mer.UserKey4 'UserKey4' ,
            mer.UserCode 'UserCode' ,
            mer.Access 'Access' ,
            mer.PromoLimit 'PromoLimit' ,
            mer.SweepRate 'SweepRate' ,
            mer.TimeZone 'TimeZone' ,
            mer.GeoCode 'GeoCode' ,
            mer.ReferRate 'ReferRate'
FROM Merchant AS mer (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mer.MemberID = me.MemberID)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (mer.CountryID = cou.CountryID)
WHERE ISNULL(mer.City, '') LIKE @SearchText + '%'
AND ISNULL(mer.City, '') + dbo.wtfn_FormatNumber(mer.MerchantID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO