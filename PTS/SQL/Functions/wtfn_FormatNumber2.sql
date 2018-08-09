IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_FormatNumber2]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_FormatNumber2]
GO

CREATE FUNCTION [dbo].[wtfn_FormatNumber2] 
(
    -- Add the parameters for the function here
    @value varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @WholeNumber varchar(50) = NULL, @Decimal varchar(10) = '', @CharIndex int = charindex('.', @value)

    IF (@CharIndex > 0)
        SELECT @WholeNumber = SUBSTRING(@value, 1, @CharIndex-1), @Decimal = SUBSTRING(@value, @CharIndex, LEN(@value))
    ELSE
        SET @WholeNumber = @value

    IF(LEN(@WholeNumber) > 3)
        SET @WholeNumber = dbo.wtfn_FormatNumber2(SUBSTRING(@WholeNumber, 1, LEN(@WholeNumber)-3)) + ',' + RIGHT(@WholeNumber, 3)

    -- Return the result of the function
    RETURN @WholeNumber + @Decimal

END
GO
