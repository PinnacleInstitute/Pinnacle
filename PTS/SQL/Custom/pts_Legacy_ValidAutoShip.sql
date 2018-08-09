EXEC [dbo].pts_CheckProc 'pts_Legacy_ValidAutoShip'
GO

--DECLARE @Result varchar(1000) EXEC pts_Legacy_ValidAutoShip '103,106,113', @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Legacy_ValidAutoShip
   @Options2 varchar(1000),
   @Result varchar(1000) OUTPUT
AS

DECLARE @tmpCode varchar(10)

SET NOCOUNT ON
SET @Result = ''

-- List these business builder packs first (they should always be extra to the ones below)
SET @tmpCode = '122' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '123' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode

SET @tmpCode = '111' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '112' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '113' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '114' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '115' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '116' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '117' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '118' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '119' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '120' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '121' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode

GO
