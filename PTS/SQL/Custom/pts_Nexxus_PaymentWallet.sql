EXEC [dbo].pts_CheckProc 'pts_Nexxus_PaymentWallet'
GO

--DECLARE @PayoutID money EXEC pts_Nexxus_PaymentWallet 37702,10,@PayoutID OUTPUT print @PayoutID

CREATE PROCEDURE [dbo].pts_Nexxus_PaymentWallet
   @MemberID int,
   @Price money, 
   @PayoutID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Available money, @Today datetime
SET @CompanyID = 21
SET @PayoutID = 0

--	Check wallet balance
SELECT @Available = ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status IN (1,4,5,7) AND Show = 0

IF @Available >= @Price
BEGIN
	SET @Price = @Price	* -1 
	SET @Today = dbo.wtfn_DateOnly(GETDATE())
--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, View, UserID
	EXEC pts_Payout_Add @PayoutID OUTPUT, @CompanyID, 4, @MemberID, @Today, @Today, @Price, 1, '', 90, '', 0, 1
END

GO
