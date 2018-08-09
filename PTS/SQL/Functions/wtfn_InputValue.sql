IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_InputValue]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_InputValue]
GO
 
CREATE FUNCTION [dbo].wtfn_InputValue ( 
		@Field varchar(30),
		@InputValues varchar(500)
		)
RETURNS varchar(30)
AS
BEGIN
	DECLARE @Return varchar(30), @pos int, @pos2 int
	SET @Return = ''
	SET @pos = CHARINDEX( @Field, @InputValues )
	IF @pos > 0
	BEGIN
		SET @pos = @pos + Len(@Field) + 1
		SET @pos2 = CHARINDEX( CHAR(13), @InputValues, @pos )
		IF @pos2 > 0 
			SET @Return = SUBSTRING( @InputValues, @pos, @pos2-@pos )
		ELSE  
			SET @Return = SUBSTRING( @InputValues, @pos, 30 )
	END
	RETURN  LTRIM(RTRIM(@Return))
END
GO

