EXEC [dbo].pts_CheckProc 'pts_Payment_GetCompany'
GO

CREATE PROCEDURE [dbo].pts_Payment_GetCompany
   @OwnerType int ,
   @OwnerID int ,
   @CompanyID int OUTPUT
AS

SET NOCOUNT ON

-- Member
IF @OwnerType = 4
BEGIN
	SELECT @CompanyID = CompanyID FROM Member WHERE MemberID = @OwnerID
END

-- Company
IF @OwnerType = 38
BEGIN
	SET @CompanyID = @OwnerID
END

-- SalesOrder
IF @OwnerType = 52
BEGIN
	SELECT @CompanyID = CompanyID FROM SalesOrder WHERE SalesOrderID = @OwnerID
END

GO
