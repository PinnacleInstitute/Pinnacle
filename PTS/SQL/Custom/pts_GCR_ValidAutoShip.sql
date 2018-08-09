EXEC [dbo].pts_CheckProc 'pts_GCR_ValidAutoShip'
GO

--DECLARE @Result varchar(1000) EXEC pts_GCR_ValidAutoShip '103,106,113', @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_GCR_ValidAutoShip
   @Options2 varchar(1000),
   @Result varchar(1000) OUTPUT
AS

DECLARE @tmpCode varchar(10)

SET NOCOUNT ON
SET @Result = ''

SET @tmpCode = '202' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '203' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '204' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '205' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '206' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '207' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode
SET @tmpCode = '208' IF CHARINDEX(@tmpCode, @Options2) > 0 SET @Result = @tmpCode

GO
