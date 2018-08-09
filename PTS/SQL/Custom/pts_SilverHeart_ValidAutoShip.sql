EXEC [dbo].pts_CheckProc 'pts_SilverHeart_ValidAutoShip'
GO

--DECLARE @Result varchar(1000) EXEC pts_SilverHeart_ValidAutoShip '103,106,113', @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_SilverHeart_ValidAutoShip
   @Options2 varchar(1000),
   @Result varchar(1000) OUTPUT
AS

DECLARE @tmpCode varchar(10)

SET NOCOUNT ON
SET @Result = ''

SET @tmpCode = '101' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '102' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '103' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '104' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode

GO
