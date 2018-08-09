EXEC [dbo].pts_CheckProc 'pts_System_GetLogon'
GO

CREATE PROCEDURE [dbo].pts_System_GetLogon (
	@Logon nvarchar(80) OUTPUT ,
	@Default nvarchar(80)
	)
AS

DECLARE	@mSeed int ,
	@mRandom float ,
	@mString varchar(9) ,
	@mLogon nvarchar(30) ,
	@mTemp nvarchar(30) ,
	@mChar tinyint ,
	@mLen tinyint ,
	@mIndex tinyint ,
	@mID int ,
	@mID2 int

SET NOCOUNT ON

IF LEN(@Default) >= 1
BEGIN
	SELECT @mID = AuthUserID FROM AuthUser WHERE Logon = @Default
	IF @mID IS NULL
		SET @Logon = @Default
END	
IF @Logon IS NULL
BEGIN
	DECLARE @mGood int
	SET @mGood = 0
	WHILE @mGood < 5
	BEGIN
--		get a seed value for the random number generator
--		EXEC pts_System_GetSeed @mSeed OUTPUT
		SET @mSeed = CAST(CAST(NEWID( ) as varbinary) as int)	

-- 		generate a random number using the seed
		SET @mRandom = RAND(@mSeed) * 1000000000

-- 		convert the foating point number to a string with 
-- 		at least 8 digits after the decimal point (style = 1)
		SET @mString = CONVERT(nvarchar(255), @mRandom, 1)
	
-- 		trim the result and remove the decimal point
		SET @mLogon = LTRIM(RTRIM(REPLACE(@mString, '.', '')))
	
--		convert some of the numbers to characters 
		SET @mLen = LEN(@mLogon)
		SET @mIndex = 1
		SET @mTemp = ''

		WHILE (@mIndex <= @mLen)
			BEGIN
			SET @mChar = CONVERT(tinyint, SUBSTRING (@mLogon,@mIndex,1)) 
			IF (@mChar= 0)
				BEGIN
					SET @mTemp = @mTemp + CHAR(90)
				END
			ELSE IF (@mChar % 2 = 0)
				BEGIN
					SET @mTemp = @mTemp + CHAR(64 + @mChar)
				END
			ELSE
				BEGIN
					SET @mTemp = @mTemp + CHAR(80 + @mChar)
				END
			SET @mIndex = @mIndex + 1
		END
		SELECT @mID2 = AuthUserID FROM AuthUser WHERE Logon = @mTemp
		IF @mID2 IS NULL 
			SET @mGood = 5

		SET @mGood = @mGood + 1
	END

--return the logon ID
	SET	@Logon = @mTemp
END

GO
