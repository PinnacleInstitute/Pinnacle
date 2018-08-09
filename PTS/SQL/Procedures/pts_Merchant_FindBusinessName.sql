EXEC [dbo].pts_CheckProc 'pts_Merchant_FindBusinessName'
 GO

CREATE PROCEDURE [dbo].pts_Merchant_FindBusinessName ( 
   @SearchText nvarchar (80),
   @Bookmark nvarchar (90),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(mer.BusinessName, '') + dbo.wtfn_FormatNumber(mer.MerchantID, 10) 'BookMark' ,
            mer.MerchantID 'MerchantID' ,
            mer.MemberID 'MemberID' ,
            mer.BillingID 'BillingID' ,
            mer.PayoutID 'PayoutID' ,
            mer.CountryID 'CountryID' ,
            cou.CountryName 'CountryName' ,
            mer.BusinessName 'BusinessName' ,
            mer.NameLast 'NameLast' ,
            mer.NameFirst 'NameFirst' ,
            mer.Email 'Email' ,
            mer.Password 'Password' ,
            mer.Status 'Status' ,
            mer.Street1 'Street1' ,
            mer.Street2 'Street2' ,
            mer.City 'City' ,
            mer.State 'State' ,
            mer.Zip 'Zip'
FROM Merchant AS mer (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (mer.CountryID = cou.CountryID)
WHERE ISNULL(mer.BusinessName, '') LIKE @SearchText + '%'
AND ISNULL(mer.BusinessName, '') + dbo.wtfn_FormatNumber(mer.MerchantID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO