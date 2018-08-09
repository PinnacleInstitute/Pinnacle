EXEC [dbo].pts_CheckProc 'pts_Debt_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Debt_ListMember
   @MemberID int ,
   @DebtType int
AS

SET NOCOUNT ON

IF @DebtType = 0
BEGIN
	SELECT DebtID, DebtType, DebtName, Balance, Payment, MinPayment, IntRate, IntPaid, MonthsPaid, IsActive, IsConsolidate
	FROM Debt (NOLOCK) WHERE MemberID = @MemberID
	ORDER BY DebtType, Balance
END
IF @DebtType = 1
BEGIN
	SELECT DebtID, DebtType, DebtName, Balance, Payment, MinPayment, IntRate, IntPaid, MonthsPaid, IsActive, IsConsolidate
	FROM Debt (NOLOCK) WHERE MemberID = @MemberID AND IsActive <> 0
	ORDER BY IntRate DESC
END
IF @DebtType = 2
BEGIN
	SELECT DebtID, DebtType, DebtName, Balance, Payment, MinPayment, IntRate, IntPaid, MonthsPaid, IsActive, IsConsolidate
	FROM Debt (NOLOCK) WHERE MemberID = @MemberID AND IsActive <> 0
	ORDER BY Balance DESC
END
IF @DebtType = 3
BEGIN
	SELECT DebtID, DebtType, DebtName, Balance, Payment, MinPayment, IntRate, IntPaid, MonthsPaid, IsActive, IsConsolidate
	FROM Debt (NOLOCK) WHERE MemberID = @MemberID AND IsActive <> 0
	ORDER BY Balance
END
IF @DebtType = 4
BEGIN
	SELECT DebtID, DebtType, DebtName, Balance, Payment, MinPayment, IntRate, IntPaid, MonthsPaid, IsActive, IsConsolidate
	FROM Debt (NOLOCK) WHERE MemberID = @MemberID AND IsActive <> 0
	ORDER BY Payment DESC
END
IF @DebtType = 5
BEGIN
	SELECT DebtID, DebtType, DebtName, Balance, Payment, MinPayment, IntRate, IntPaid, MonthsPaid, IsActive, IsConsolidate
	FROM Debt (NOLOCK) WHERE MemberID = @MemberID AND IsActive <> 0
	ORDER BY Payment
END

GO