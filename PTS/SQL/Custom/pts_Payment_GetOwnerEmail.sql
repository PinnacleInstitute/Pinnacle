EXEC [dbo].pts_CheckProc 'pts_Payment_GetOwnerEmail'
GO

CREATE PROCEDURE [dbo].pts_Payment_GetOwnerEmail
   @OwnerType int ,
   @OwnerID int ,
   @Email nvarchar (100) OUTPUT
AS

SET NOCOUNT ON

-- Member
IF @OwnerType = 4
BEGIN
	SELECT @Email = Email FROM Member WHERE MemberID = @OwnerID
END

-- SalesOrder
IF @OwnerType = 52
BEGIN
	SELECT @Email = me.Email 
	FROM SalesOrder AS so
	JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE so.SalesOrderID = @OwnerID
END

-- Company
IF @OwnerType = 38
BEGIN
	SELECT @Email = Email FROM Company WHERE CompanyID = @OwnerID
END

GO
