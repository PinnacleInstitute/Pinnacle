EXEC [dbo].pts_CheckProc 'pts_Commission_CompanyCommissions'
GO

CREATE PROCEDURE [dbo].pts_Commission_CompanyCommissions
   @CompanyID int ,
   @CommType int ,
   @CommDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON
SET @Count = 0

DECLARE @CommPlan int
SET @CommPlan = @CommType

DECLARE @PaymentID int, @MemberID int, @Amount money, @ProductCode varchar(10), @PromotionID int
IF @CommDate = 0 SET @CommDate = dbo.wtfn_DateOnly(GETDATE())

-- Set all Members Commissionable Title for the specified Commission date
-- EXEC pts_Member_SetCommTitle @CompanyID, @CommDate

-- Get all commissionable payments for products of the specified commission plan
DECLARE Payment_cursor CURSOR LOCAL STATIC FOR 
SELECT pa.PaymentID, so.MemberID, pa.Commission, pr.Code, so.PromotionID
FROM   Payment AS pa 
JOIN   SalesOrder AS so ON ( pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID )
JOIN   Product AS pr ON pa.ProductID = pr.ProductID
WHERE  so.CompanyID = @CompanyID AND pr.CommPlan = @CommPlan
AND    pa.Status = 3 AND pa.CommStatus = 1 AND pa.PayDate <= @CommDate

OPEN Payment_cursor
FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Amount, @ProductCode, @PromotionID

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @CompanyID = 1 EXEC pts_Commission_Company_1 @CompanyID, @CommPlan, @PaymentID, @ProductCode, @CommDate, @MemberID, @Amount, @PromotionID

--	Update Payment Commission Status and date
	UPDATE Payment SET CommStatus = 2, CommDate = @CommDate WHERE PaymentID = @PaymentID

	SET @Count = @Count + 1
	FETCH NEXT FROM Payment_cursor INTO @PaymentID, @MemberID, @Amount, @ProductCode, @PromotionID
END
CLOSE Payment_cursor
DEALLOCATE Payment_cursor

GO
