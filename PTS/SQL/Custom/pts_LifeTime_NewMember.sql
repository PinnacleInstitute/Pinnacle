EXEC [dbo].pts_CheckProc 'pts_LifeTime_NewMember'
GO

--declare @Result varchar(1000) EXEC pts_LifeTime_NewMember 10745, @Result output print @Result

CREATE PROCEDURE [dbo].pts_LifeTime_NewMember
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @ReferralID int, @cnt int, @Options2 varchar(40), @Price money, @ID int, @PayDate datetime, @PayType int, @Description varchar(200)
SET @CompanyID = 8

-- *******************************************************************
--  New Member Activation
-- *******************************************************************
SELECT @Options2 = Options2 FROM Member WHERE MemberID = @MemberID

-- Set Status to Active
UPDATE Member SET Status = 1 WHERE MemberID = @MemberID

SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
EXEC pts_Commission_CalcAdvancement_8 @ReferralID, @cnt OUTPUT

-- Process 2nd Enrollment Payment Option
IF @Options2 != ''
BEGIN
	SET @Price = CAST(@Options2 AS money)
	SELECT @PayDate = DATEADD(m,1,PayDate), @PayType = PayType, @Description = Description FROM Payment WHERE OwnerType = 4 and OwnerID = @MemberID
	
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--	Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType, TokenOwner,Token,UserID
	EXEC pts_Payment_Add @ID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, 0, @PayDate, 0, @PayType, 
		 @Price, @Price, 0, 0, 0, @Description, '2nd Enrollment Payment', 1, '', '', 1, 0, 0, 0, 0, 1
END

SET @Result = CAST(@cnt AS VARCHAR(10))

GO