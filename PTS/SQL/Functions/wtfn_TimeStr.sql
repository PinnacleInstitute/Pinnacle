IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_TimeStr]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_TimeStr]
GO

--select dbo.wtfn_TimeStr(GETDATE())

CREATE FUNCTION [dbo].wtfn_TimeStr ( 
		@datein datetime
		)
RETURNS varchar(10)
AS
BEGIN
	DECLARE	@mTimeText varchar(10)

	SET		@mTimeText = 
			CAST( DATEPART(hh,@datein) AS varchar(2)) + ':' + 
			CAST(DATEPART(mi,@datein) AS varchar(2)) + ':' + 
			CAST(DATEPART(ss,@datein) AS varchar(4))

	RETURN	(@mTimeText)
END
GO