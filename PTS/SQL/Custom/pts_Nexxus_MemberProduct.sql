EXEC [dbo].pts_CheckProc 'pts_Nexxus_MemberProduct'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_MemberProduct 39464, @Result output print @Result
--select * from Member where CompanyID = 21 order by MemberID desc

CREATE PROCEDURE [dbo].pts_Nexxus_MemberProduct
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Date datetime, @PaymentID int, @Purpose varchar(100), @Product int, @cnt int, @Title int, @Test int
SET @PaymentID = 0
SET @Product = 0
SET @Test = 0

SELECT @Title = Title FROM Member WHERE MemberID = @MemberID

-- CHECK ACCESS TO AN AFFILIATE PACKAGE
IF @Title > 1
BEGIN
	IF @Test > 0 PRINT 'Affiliate'
	SET @Date = DATEADD( day, -31, GETDATE() )
	SELECT TOP 1 @PaymentID = PaymentID, @Purpose = Purpose FROM Payment 
	WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND PaidDate > @Date
--	WHERE OwnerType = 4 AND OwnerID = @MemberID
	AND Purpose IN ('101','102','103','106','107','108')
	ORDER BY Purpose DESC

	--Did we find a payment
	IF @PaymentID > 0
	BEGIN
		IF @Purpose IN ('101','106') SET @Product = 201 
		IF @Purpose IN ('102','107') SET @Product = 204 
		IF @Purpose IN ('103','108') SET @Product = 205 
	END
END

-- IF No Product, Check for a customer payment
IF @Product = 0
BEGIN
	IF @Test > 0 PRINT 'Customer'
	SET @Purpose = ''
	SET @Date = DATEADD( year, -1, GETDATE() )

	SELECT TOP 1 @Purpose = Purpose FROM Payment 
	WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND PaidDate > @Date 
	AND Purpose IN ('200','201','202','203','204','205')
	ORDER BY Purpose DESC

	--Did we find a payment
	IF @Purpose != '' SET @Product = CAST(@Purpose AS INT)
END

-- IF No Product, Check for a Course Certificate
IF @Product = 0
BEGIN
	IF @Test > 0 PRINT 'Certificate'
	SET @Purpose = ''
	SET @Date = DATEADD( year, -1, GETDATE() )
	IF @Test > 0 PRINT @Date
	SELECT TOP 1 @Purpose = Purpose FROM Gift 
	WHERE Member2ID = @MemberID AND ActiveDate > @Date 
	AND Purpose IN ('200','201','202','203','204','205')
	ORDER BY Purpose DESC

	--Did we find a gift certificate
	IF @Purpose != '' SET @Product = CAST(@Purpose AS INT)
END

SET @Result = CAST( @Product AS VARCHAR(4))

GO


