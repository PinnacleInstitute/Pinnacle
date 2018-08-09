IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_Max]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_Max]
GO
--select dbo.wtfn_Max( 7,5)

CREATE FUNCTION [dbo].wtfn_Max ( 
		@Number money ,
		@Max money 
		)
RETURNS money
AS
BEGIN
	IF @Number > @Max SET @Number = @Max
	RETURN	@Number
END
GO
