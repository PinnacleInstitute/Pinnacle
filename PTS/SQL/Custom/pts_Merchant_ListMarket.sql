EXEC [dbo].pts_CheckProc 'pts_Merchant_ListMarket'
GO

--EXEC pts_Merchant_ListMarket '75075,75093,75023,75024', 224

CREATE PROCEDURE [dbo].pts_Merchant_ListMarket
   @Target nvarchar (200) ,
   @CountryID int
AS

SET NOCOUNT ON

DECLARE @pos int, @val NVARCHAR(20)
DECLARE @TargetTable TABLE (Target nvarchar(20))

--Parse Target Values
WHILE @Target <> ''
BEGIN
	SET @pos = CHARINDEX(',', @Target )
	IF @pos = 0
		BEGIN SET @val = @Target SET @Target = '' END
	ELSE	
		BEGIN SET @val = Left(@Target, @pos - 1) SET @Target = SUBSTRING(@Target, @pos+1, LEN(@Target)) END
	INSERT @TargetTable VALUES ( @val )
END 

SELECT   m.MerchantID, m.MerchantName, m.Phone, m.Email, m.Street1, m.Street2, m.City, m.State, m.Zip, m.Description, 
 m.Rating, m.CurrencyCode, m.EnrollDate, m.IsOrg, m.Options, m.StoreOptions, m.GeoCode, 
 a.Amount AS 'RewardAmt', a.Description AS 'RewardDesc', a.Cap AS 'RewardCap'
FROM Merchant AS m (NOLOCK)
CROSS APPLY
(
SELECT  TOP 1 Amount, Description, Cap
FROM    Award
WHERE   MerchantID = m.MerchantID
AND AwardType = 1 AND Status = 1
ORDER BY seq
) AS a        
WHERE Status = 3
AND m.CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = m.Zip)  
ORDER BY m.MerchantName

GO