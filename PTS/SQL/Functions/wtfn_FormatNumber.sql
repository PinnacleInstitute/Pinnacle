IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_FormatNumber]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_FormatNumber]
GO

CREATE FUNCTION [dbo].wtfn_FormatNumber ( 
		@NumberIn int ,
		@Length tinyint 
		)
RETURNS nvarchar(20)
AS
BEGIN
	DECLARE	@mStringNo nvarchar(20)
	SET			@mStringNo = RIGHT(REPLICATE('0',@Length) + CONVERT(nvarchar(20), @NumberIn),@Length)
	RETURN	(@mStringNo)
END
GO