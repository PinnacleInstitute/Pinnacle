EXEC [dbo].pts_CheckProc 'pts_System_GetPassword'
GO
--declare @Seed int exec pts_System_GetSeed @Seed OUTPUT print @Seed
--declare @Password nvarchar(30) exec pts_System_GetPassword @Password OUTPUT print @Password

CREATE PROCEDURE [dbo].pts_System_GetPassword (
	@Password nvarchar(30) OUTPUT 
	)
AS

DECLARE	@mSeed int,
			@mRandom float,
			@mString varchar(9)

SET			NOCOUNT ON

-- get a seed value for the random number generator
EXEC		pts_System_GetSeed
			@mSeed OUTPUT

-- generate a random number using the seed
SET			@mRandom = RAND(@mSeed) * 1000000000

-- convert the foating point number to a string with 
-- at least 8 digits after the decimal point (style = 1)
SET			@mString = CONVERT(nvarchar(255), @mRandom, 1)

-- trim the result and remove the decimal point
SET			@Password = LTRIM(RTRIM(REPLACE(@mString, '.', '')))
GO

