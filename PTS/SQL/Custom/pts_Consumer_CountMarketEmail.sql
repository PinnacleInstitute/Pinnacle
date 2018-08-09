EXEC [dbo].pts_CheckProc 'pts_Consumer_CountMarketEmail'
GO

--DECLARE @Cnt nvarchar(100) EXEC pts_Consumer_CountMarketEmail 21, '75075,75093,75023,75024', 224, @Cnt OUTPUT PRINT @Cnt

CREATE PROCEDURE [dbo].pts_Consumer_CountMarketEmail
   @CompanyID int ,
   @Target nvarchar (200) ,
   @CountryID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

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

SELECT @Result = COUNT(*) FROM Consumer (NOLOCK)
WHERE Status = 2 AND Messages NOT IN (2,4)
AND ( ( CountryID = @CountryID AND EXISTS (SELECT * FROM @TargetTable WHERE Target = Zip) ) 
OR ( CountryID2 = @CountryID AND EXISTS (SELECT Target FROM @TargetTable WHERE Target = Zip2) ) )

GO