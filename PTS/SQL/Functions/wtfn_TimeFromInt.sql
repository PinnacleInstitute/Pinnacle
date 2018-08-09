IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_TimeFromInt]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_TimeFromInt]
GO

CREATE FUNCTION [dbo].wtfn_TimeFromInt ( 
		@timein int
		)
RETURNS nvarchar(10)
AS
BEGIN
	DECLARE @mTime nvarchar(10)
	SET @mTime = REPLICATE('0', (4-LEN(CAST(@timein AS nvarchar(4))))) + CAST(@timein AS nvarchar(4))
	SET @mTime = LEFT(@mTime, 2) + ':' + RIGHT(@mTime, 2)
	RETURN	(@mTime)
END
GO

