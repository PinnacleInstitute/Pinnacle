IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_DateOnlyStr]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_DateOnlyStr]
GO

CREATE FUNCTION [dbo].wtfn_DateOnlyStr ( 
		@datein datetime
		)
RETURNS varchar(10)
AS
BEGIN
	RETURN  CAST( MONTH(@datein) AS varchar(2)) + '/' + 
			CAST(DAY(@datein) AS varchar(2)) + '/' + 
			CAST(YEAR(@datein) AS varchar(4))
END
GO