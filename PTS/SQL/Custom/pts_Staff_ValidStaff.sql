EXEC [dbo].pts_CheckProc 'pts_Staff_ValidStaff'
GO

--DECLARE @Result nvarchar (1000) EXEC pts_Staff_ValidStaff 1, 1234, 1, @Result OUTPUT  PRINT @Result

CREATE PROCEDURE [dbo].pts_Staff_ValidStaff
   @MerchantID int ,
   @Code int ,
   @Status int ,
   @Result nvarchar (1000) OUTPUT
AS
-- If @Status = 0 Look for active staff only else look for any status

SET NOCOUNT ON

DECLARE @StaffID int, @Stat int, @Access varchar(80)   
SET @Result = ''

SELECT @StaffID = ISNULL(StaffID,0), @Access = Access FROM Staff 
WHERE MerchantID = @MerchantID AND Code = @Code AND (@Status = 1 OR Status = 1) 

IF @StaffID > 0
	SET @Result = CAST(@StaffID AS VARCHAR(10)) + '|' + @Access
ELSE
	SET @Result = '0'

GO