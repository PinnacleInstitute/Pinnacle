EXEC [dbo].pts_CheckProc 'pts_Consumer_Stats'
GO
--DECLARE @Result varchar(50) EXEC pts_Consumer_Stats '23430,30307', @Result OUTPUT PRINT @Result
--select * from merchant
--select * from consumer where Zip = '23430'

CREATE PROCEDURE [dbo].pts_Consumer_Stats
   @Target varchar (200) ,
   @Result varchar(100) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @pos int, @val int, @shoppers int, @orgs int, @merchants int 
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

-- Total Shoppers
SELECT @shoppers = COUNT(*) FROM Consumer (NOLOCK)
WHERE EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip)  

-- Total Organizations
SELECT @orgs = COUNT(*) FROM Merchant (NOLOCK)
WHERE IsOrg <> 0 AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip)  

-- Total Merchants
SELECT @merchants = COUNT(*) FROM Merchant (NOLOCK)
WHERE IsOrg = 0 AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip)  

SET @Result = CAST(@shoppers AS VARCHAR(10)) + ',' + CAST(@orgs AS VARCHAR(10)) + ',' + CAST(@merchants AS VARCHAR(10)) 

GO