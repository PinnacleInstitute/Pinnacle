IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_DateOnly]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_DateOnly]
GO

CREATE FUNCTION [dbo].wtfn_DateOnly ( 
		@datein datetime
		)
RETURNS datetime
AS
BEGIN
	DECLARE	@mDateText varchar(10) , 
				@mDateOut datetime

	SET		@mDateText = 
			CAST( MONTH(@datein) AS varchar(2)) + '/' + 
			CAST(DAY(@datein) AS varchar(2)) + '/' + 
			CAST(YEAR(@datein) AS varchar(4))
	SET		@mDateOut = 	CAST(@mDateText AS datetime)

	RETURN	(@mDateOut)
END
GO