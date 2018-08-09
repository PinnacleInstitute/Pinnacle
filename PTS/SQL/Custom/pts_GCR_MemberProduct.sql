EXEC [dbo].pts_CheckProc 'pts_GCR_MemberProduct'
GO

--declare @Result varchar(1000) EXEC pts_GCR_MemberProduct 12559, @Result output print @Result
--select * from Member where CompanyID = 17 order by MemberID desc

CREATE PROCEDURE [dbo].pts_GCR_MemberProduct
   @MemberID int ,
   @Program int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Date datetime, @PaymentID int, @Purpose varchar(100), @Product int, @cnt int
SET @Date = DATEADD( d, -31, GETDATE() )
SET @PaymentID = 0
SET @Product = 0

-- CHECK CURRENT ACCESS TO A SILVER OR GOLD PACKAGE
IF @MemberID IN (12046,12048,12551,12556,12561,19469)
BEGIN
	SET @Product = 3
END
ELSE	
BEGIN
	SELECT TOP 1 @PaymentID = PaymentID, @Purpose = Purpose FROM Payment 
	WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND PaidDate > @Date
	AND Purpose IN ('104', '204','105', '205')
	ORDER BY Purpose DESC

	--Did we find a payment
	IF @PaymentID > 0
	BEGIN
		IF @Purpose = '104' OR @Purpose = '204' SET @Product = 2 
		IF @Purpose = '105' OR @Purpose = '205' SET @Product = 3 
	END
END

-- CHECK ACCESS TO A SPECIFIC CERTIFICATION PROGRAM
IF @Program > 0
BEGIN
	-- Certification Programs are included in the Packages
	IF @Product > 0 
	BEGIN
		SET @Product = @Program
	END
	ELSE	
	BEGIN
		-- Check for the purchased Certification Program
		SET @Purpose = '30' + CAST(@Program AS CHAR(1))
		SET @cnt = 0
		SELECT @cnt = COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status = 3 AND Purpose = @Purpose

		--Did we find a payment
		IF @cnt > 0 SET @Product = @Program
	END
END

SET @Result = CAST( @Product AS VARCHAR(2))

GO

