EXEC [dbo].pts_CheckProc 'pts_Merchant_CountMarket'
GO

--DECLARE @Cnt nvarchar(100) EXEC pts_Merchant_CountMarket '75023,75024,75025,75026,75034,75074,75075,75084,75086,75093,75094,75252', 224, @Cnt OUTPUT PRINT @Cnt
--select * from Merchant

CREATE PROCEDURE [dbo].pts_Merchant_CountMarket
   @Target nvarchar (200) ,
   @CountryID int ,
   @Result nvarchar (100) OUTPUT
AS

SET NOCOUNT ON

DECLARE @pos int, @val NVARCHAR(20)
DECLARE @TargetTable TABLE (Target nvarchar(20))
DECLARE @Merchants int, @Orgs int
SET @Merchants = 0
SET @Orgs = 0

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

SELECT @Merchants = COUNT(*) FROM Merchant 
WHERE Status = 3 AND IsOrg = 0
AND CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip)  

SELECT @Orgs = COUNT(*) FROM Merchant 
WHERE Status = 3 AND IsOrg != 0
AND CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip)  

SET @Result = CAST(@Merchants AS VARCHAR(10)) + '|' + CAST(@Orgs AS VARCHAR(10))

GO