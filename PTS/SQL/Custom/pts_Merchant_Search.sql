EXEC [dbo].pts_CheckProc 'pts_Merchant_Search'
 GO

--DECLARE @MaxRows tinyint EXEC pts_Merchant_Search 'french', '', @MaxRows OUTPUT
--DECLARE @MaxRows tinyint EXEC pts_Merchant_Search '"FORMSOF(INFLECTIONAL,tx) OR FORMSOF(INFLECTIONAL,plano)"', '', @MaxRows OUTPUT


CREATE PROCEDURE [dbo].pts_Merchant_Search ( 
      @SearchText nvarchar (200),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT
      )
AS

SET            NOCOUNT ON

SET            @MaxRows = 20

IF @Bookmark = '' 
	SET @Bookmark = '9999'

SELECT TOP 21
	dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(me.MerchantID, 10) 'BookMark' ,
	me.MerchantID,
	me.MerchantName,
	me.NameLast,
	me.NameFirst,
	me.Email2,
	me.Phone2,
	me.Street1,
	me.Street2,
	me.City,
	me.State,
	me.Zip,
	me.EnrollDate,
	co.CountryName,
	me.Description,
	me.StoreOptions,
	me.Colors,
	me.Rating,
	me.CurrencyCode
FROM Merchant AS me
LEFT OUTER JOIN Country AS co (NOLOCK) ON (me.CountryID = co.CountryID)
INNER JOIN CONTAINSTABLE(MerchantFT,*, @SearchText, 1000 ) AS K ON me.MerchantID = K.[KEY]
WHERE dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(me.MerchantID, 10) <= @Bookmark
AND me.Status = 3
ORDER BY 'Bookmark' desc 

GO
