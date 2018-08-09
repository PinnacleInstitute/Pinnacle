EXEC [dbo].pts_CheckProc 'pts_Consumer_ListMarketEmail'
GO

--EXEC pts_Consumer_ListMarketEmail 21, '75075,75093,75023,75024', 224

CREATE PROCEDURE [dbo].pts_Consumer_ListMarketEmail
   @CompanyID int ,
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

SELECT co.ConsumerID,
	CASE co.MerchantID WHEN 0 THEN co.MemberID ELSE me.MemberID END 'MemberID',
    co.Email, 
    co.NameLast, 
    co.NameFirst
FROM Consumer AS co (NOLOCK)
LEFT OUTER JOIN Merchant AS me ON co.MerchantID = me.MerchantID
WHERE co.Status = 2 AND co.Messages NOT IN (2,4)
AND ( ( co.CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = co.Zip) ) 
OR ( co.CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = co.Zip2) ) )

GO