EXEC [dbo].pts_CheckProc 'pts_Expense_GetVehicleMethod'
GO

CREATE PROCEDURE [dbo].pts_Expense_GetVehicleMethod
   @MemberID int ,
   @ExpDate datetime ,
   @Method int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Year int
SET @Year = YEAR(@ExpDate)
SET @Method = -1
SELECT @Method = ISNULL(VehicleMethod,0) FROM MemberTax WHERE MemberID = @MemberID AND Year = @Year

GO